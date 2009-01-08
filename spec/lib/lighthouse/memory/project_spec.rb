require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/memory/project"

describe Lighthouse::Memory::Project, "tickets" do
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
end

describe Lighthouse::Memory::Project, "with no milestones" do
  before(:each) do
    @project = Lighthouse::Memory::Project.new
  end
  
  it "should have milestones" do
    @project.milestones.should == []
  end
  
  it "should have milestone_titles" do
    @project.milestone_titles.should == []
  end
  
  it "should respond to milestone_title given an id" do
    @project.milestone_title(1).should == nil
  end
  
  it "should respond to milestone_id given a title" do
    @project.milestone_id("title").should == nil
  end
end

describe Lighthouse::Memory::Project, "with one milestone" do
  before(:each) do
    @project = Lighthouse::Memory::Project.new
    @milestone_one = Lighthouse::Memory::Milestone.new({:title => "title one", :id => "id one"})
    @project.milestones << @milestone_one
  end

  it "should have milestones" do
    @project.milestones.should == [@milestone_one]
  end
  
  it "should have milestone_titles" do
    @project.milestone_titles.should == ["title one"]
  end
  
  it "should respond to milestone_title given an id" do
    @project.milestone_title("id one").should == "title one"
  end
  
  it "should respond to milestone_id given a title" do
    @project.milestone_id("title one").should == "id one"
  end
end

describe Lighthouse::Memory::Project, "with two milestones" do
  before(:each) do
    @project = Lighthouse::Memory::Project.new
    @milestone_one = Lighthouse::Memory::Milestone.new({:title => "title one", :id => "id one"})
    @milestone_two = Lighthouse::Memory::Milestone.new({:title => "title two", :id => "id two"})
    @project.milestones << @milestone_one
    @project.milestones << @milestone_two
  end

  it "should have milestones" do
    @project.milestones.should == [@milestone_one, @milestone_two]
  end
  
  it "should have milestone_titles" do
    @project.milestone_titles.should == ["title one", "title two"]
  end
  
  it "should respond to milestone_title given an id" do
    @project.milestone_title("id two").should == "title two"
  end
  
  it "should respond to milestone_id given a title" do
    @project.milestone_id("title two").should == "id two"
  end
end

describe Lighthouse::Memory::Project, "ticket states" do
  before(:each) do
    @project = Lighthouse::Memory::Project.new
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