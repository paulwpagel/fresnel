require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse"


def create_project
  project = Lighthouse::Project.new
  project.save
  return project
end

def create_project_membership(project_id)
  membership = Lighthouse::ProjectMembership.new(:project_id => project_id)
  membership.save
  return membership
end

def create_milestone(options)
  milestone = Lighthouse::Milestone.new(options)
  milestone.save
  return milestone
end

def create_ticket(project_id)
  ticket = Lighthouse::Ticket.new(:project_id => project_id)
  ticket.save
  return ticket
end

describe Lighthouse, "base methods" do
  it "should have an account= method" do
    Lighthouse.account = "some value"
  end
  
  it "should authenticate" do
    Lighthouse.authenticate("username", "password").should == true
  end
end


describe Lighthouse::User do
  it "should exist" do
    Lighthouse::User.new
  end
  
  it "should have basic user informartion" do
    user = Lighthouse::User.new(:name => "Eric", :id => "User ID")

    user.name.should == "Eric"
    user.id.should == "User ID"
  end
end

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

describe Lighthouse::Milestone do
  before(:each) do
    Lighthouse::Milestone.destroy_all
    @milestone = create_milestone(:project_id => "project_id", :title => "Milestone One")
  end

  it "should have basic information" do
    @milestone.project_id.should == "project_id"
    @milestone.title.should == "Milestone One"
  end

  it "should find one milestone by project id" do
    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.should == [@milestone]
  end
  
  it "should not find a milestone if the project_id does not match" do
    milestone_two = create_milestone(:project_id => "different id", :title => "Milestone Two")

    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.should == [@milestone]
  end

  it "should not duplicate objects on save" do
    @milestone.save
    
    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.size.should == 1
  end
end

describe Lighthouse::ProjectMembership do
  before(:each) do
    Lighthouse::Project.destroy_all
    Lighthouse::ProjectMembership.destroy_all
    @project_one = create_project
    @membership = Lighthouse::ProjectMembership.new(:project_id => @project_one.id)
  end
  
  it "should no users for a project" do
    Lighthouse::ProjectMembership.all_users_for_project("some id").should == []
  end
  
  it "should have a project_id" do
    @membership.project_id.should == @project_one.id
  end
  
  it "should have a save method" do
    @membership.save
  end
  
  it "should find an empty list of memberships for a given project" do
    find_all(@project_one.id).should == []
  end
  
  it "should find one membership for one project" do
    membership = create_project_membership(@project_one.id)

    find_all(@project_one.id).should == [membership]
  end
  
  it "should find one membership for a multiple projects" do
    membership_one = create_project_membership(@project_one.id)
    project_two = create_project
    membership_two = create_project_membership(project_two.id)
  
    find_all(@project_one.id).should == [membership_one]
    find_all(project_two.id).should == [membership_two]
  end
  
  def find_all(project_id)
    return Lighthouse::ProjectMembership.find(:all, :params => {:project_id => project_id})
  end
  
end