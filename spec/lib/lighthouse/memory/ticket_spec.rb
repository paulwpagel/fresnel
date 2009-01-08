require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/memory/project"

describe Lighthouse::Memory::Ticket do
  it "should have an id" do
    ticket = Lighthouse::Memory::Ticket.new({:id => "some id"})
    
    ticket.id.should == "some id"
  end
  
  it "should have a status" do
    ticket = make_ticket({:status => "state:open"})

    ticket.status.should == "state:open"
  end
  
  it "should allow the status to be writable" do
    ticket = make_ticket
    ticket.status = "new status"
    
    ticket.status.should == "new status"
  end
  
  it "should accept a title on init" do
    ticket = make_ticket({:title => "ticket title"})

    ticket.title.should == "ticket title"
  end

  it "should allow the title to be writable" do
    ticket = make_ticket
    ticket.title = "new title"

    ticket.title.should == "new title"
  end
  
  it "should accept a milestone_id on init" do
    ticket = make_ticket({:milestone_id => "ticket milestone_id"})

    ticket.milestone_id.should == "ticket milestone_id"
  end

  it "should allow the milestone_id to be writable" do
    ticket = make_ticket
    ticket.milestone_id = "new milestone_id"

    ticket.milestone_id.should == "new milestone_id"
  end
  
  it "should accept a project_id on init" do
    ticket = make_ticket({:project_id => "ticket project_id"})

    ticket.project_id.should == "ticket project_id"
  end
  
  it "should accept a description on init" do
    ticket = make_ticket({:description => "ticket description"})

    ticket.description.should == "ticket description"
  end

  it "should allow the description to be writable" do
    ticket = make_ticket
    ticket.description = "new description"

    ticket.description.should == "new description"
  end
  
  def make_ticket(options={})
    return Lighthouse::Memory::Ticket.new(options)
  end
  
  it "should get the milestone from the project" do
    milestone = Lighthouse::Memory::Milestone.new(:title => "completion", :id => 2)
    ticket = Lighthouse::Memory::Ticket.new({:title => "title", :status => "state:open", :milestone_id => milestone.id })
    project = Lighthouse::Memory::Project.new(:name => "test_project")
    project.milestones << milestone
    
    ticket.milestone(project).should == milestone
  end
end

describe Lighthouse::Memory::Ticket, "find_tickets" do
  it "should return no tickets" do
    Lighthouse::Memory::Ticket.find_tickets("project id", "query").should == []
  end
end