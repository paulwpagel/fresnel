require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/memory/project"

describe Lighthouse::Memory::Project do
  before(:each) do
    @project = Lighthouse::Memory::Project.new
    @ticket1 = Lighthouse::Memory::Ticket.new(:status => "state:new")
    @ticket2 = Lighthouse::Memory::Ticket.new(:status => "state:open")
    @project.tickets << @ticket1 << @ticket2
  end
  
  it "should list all open tickets" do
    @project.open_tickets.should == [@ticket2]
  end
  
  it "should list all tickets" do
    @project.all_tickets.should == [@ticket1, @ticket2]
  end
  
  it "should have milestones" do
    @project.milestones.should == []
  end
  
  it "should have milestone_titles" do
    @project.milestone_titles.should == []
  end
  
  it "should respond to milestone_title given an id" do
    @project.milestone_title(1).should == ""
  end
  
  it "should respond to milestone_id given a title" do
    @project.milestone_id("title").should == ""
  end
  
  it "should give the open states" do
    @project.open_states.should == ["new", "open"]
  end
  
  it "should give the closed states" do
    @project.closed_states.should == ["resolved", "hold", "invalid"]
  end
  
  it "should give all states" do
    @project.all_states.should == ["new", "open", "resolved", "hold", "invalid"]
  end
end