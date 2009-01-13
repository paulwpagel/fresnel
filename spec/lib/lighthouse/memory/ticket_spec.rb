require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/memory_spec_helper")
require "lighthouse/lighthouse"

describe Lighthouse::Ticket::TicketVersion do
  it "should have a body" do
    version = Lighthouse::Ticket::TicketVersion.new(:body => "Some Body")
    
    version.body.should == "Some Body"
  end
end

describe Lighthouse::Ticket do
  before(:each) do
    Lighthouse::Project.destroy_all
    Lighthouse::Ticket.destroy_all
    @project = create_project    
    @ticket = Lighthouse::Ticket.new(:project_id => @project.id)
  end
  
  it "should have a project_id" do
    @ticket.project_id.should == @project.id
  end
  
  it "should not have an id before being saved" do
    @ticket.id.should be_nil
  end
  
  it "should default the state to new" do
    @ticket.state.should == "new"
  end
  
  it "should have tags" do
    @ticket.tags = "new tags"
  end
  
  it "should have read/writable basic informatioin" do
    [:state, :title, :body, :body_html, :assigned_user_id, :milestone_id].each do |attribute|
      @ticket.send("#{attribute}=", "value")

      @ticket.send(attribute).should == "value"
    end
  end
  
  it "should have no versions before saving" do
    @ticket.versions.should == []
  end
  
  it "should have one version after being saved once" do
    @ticket.body = "Some Description"
    @ticket.save
    @ticket.versions.size.should == 1
    @ticket.versions.first.body.should == "Some Description"
  end

  describe "with one saved ticket" do
    before(:each) do
      @ticket.save
    end
    
    it "should have a unique id after saving" do
      @ticket.id.should_not be_nil
      ticket_two = create_ticket(@project.id)
    
      @ticket.id.should_not == ticket_two.id
    end
    
    it "should have a find method that returns all tickets for a project when searching for all tickets" do
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :q => "all"})
    
      tickets.size.should == 1
      tickets[0].should == @ticket
    end
    
    it "should not return tickets on a different project" do
      project_two = create_project
      ticket_two = create_ticket(project_two.id)
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :q => "all"})

      tickets.size.should == 1
      tickets[0].should == @ticket
    end
  
    it "should find a single ticket for one project" do
      found_ticket = Lighthouse::Ticket.find(@ticket.id, :params => {:project_id => @projectid})
    
      found_ticket.should == @ticket
    end
  
    it "should find a different ticket for one project" do
      ticket_two = create_ticket(@project.id)
      found_ticket = Lighthouse::Ticket.find(ticket_two.id, :params => {:project_id => @project.id})
    
      found_ticket.should == ticket_two
    end
    
    it "should find a ticket on a different project" do
      project_two = create_project
      ticket_two = create_ticket(project_two.id)
      found_ticket = Lighthouse::Ticket.find(ticket_two.id, :params => {:project_id => project_two.id})
    
      found_ticket.should == ticket_two
    end
    
    it "should find no tickets if there are no open tickets" do
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :q => "state:open"})
      
      tickets.should be_empty
    end
    
    it "should find open tickets" do
      @ticket.state = "open"
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :q => "state:open"})
      
      tickets.should == [@ticket]
    end
    
    it "should not duplicate a ticket on save" do
      @ticket.title = "New Title"
      @ticket.save
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :q => "all"})
      
      tickets.size.should == 1
      tickets[0].title.should == "New Title"
    end
  end
end