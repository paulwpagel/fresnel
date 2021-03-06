require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/memory_spec_helper")
require "lighthouse/memory/project"
require "lighthouse/lighthouse"

describe Lighthouse::Project do
  before(:each) do
    Lighthouse::Project.destroy_all
    @project = Lighthouse::Project.new(:name => "Some Name", :account => "some account")
  end
  
  it "should have a name" do
    @project.name.should == "Some Name"
  end
  
  it "should not have an id before being saved" do
    @project.id.should be_nil
  end

  it "should have a unique id after saving" do
    @project.save
    @project.id.should_not be_nil
    project_two = create_project
    
    @project.id.should_not == project_two.id
  end
  
  it "should find all projects" do
    Lighthouse.account = "some account"
    Lighthouse::Project.find(:all).size.should == 0
    @project.save
    
    Lighthouse::Project.find(:all).should == [@project]
  end
  
  it "should not find projects that do not match the account" do
    Lighthouse.account = "some different account"
    Lighthouse::Project.find(:all).size.should == 0
    @project.save
    
    Lighthouse::Project.find(:all).should == []
  end
  
  it "should have no milestones" do
    @project.milestones.should == []
  end
  
  it "should have one milestone" do
    @project.save
    milestone = create_milestone(:project_id => @project.id, :title => "Milestone One")

    @project.milestones.should == [milestone]
  end
  
  it "should have two milestones" do
    @project.save
    milestone_one = create_milestone(:project_id => @project.id, :title => "Milestone One")
    milestone_two = create_milestone(:project_id => @project.id, :title => "Milestone Two")

    @project.milestones.should == [milestone_one, milestone_two]
  end

  it "should have an open_states_list" do
    @project.open_states_list.should == "new,open"
  end
  
  it "should have an closed_states_list" do
    @project.closed_states_list.should == "resolved,hold,invalid"
  end
  
  it "should have users" do
    @project.users.size.should == 0
    @project.users << Lighthouse::User.new(:name => "Bob")
    @project.users.size.should == 1
  end

  it "should know what account it belongs to" do
    @project.account.should == "some account"
  end
  
  describe "with tickets" do
    before(:each) do
      @project.save      
      @ticket_one = Lighthouse::Ticket.new(:project_id => @project.id, :tag => "bug")
      @ticket_one.save
      @ticket_two = Lighthouse::Ticket.new(:project_id => @project.id)
      @ticket_two.save
    end
    
    it "should return the tickets" do
      @project.tickets.should == [@ticket_one, @ticket_two]
    end
    
    it "should have a tags" do
      @project.tags.size.should == 1
      @project.tags[0].name.should == "bug"
    end
  end
end
