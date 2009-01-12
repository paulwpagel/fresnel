require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require 'lighthouse/memory/base'

describe Lighthouse::Memory do
  before(:each) do
    @project = Lighthouse::Memory::Project.new(:name => "new")
  end
  it "should be a promiscuous log in" do
    Lighthouse::Memory::login_to("AFlight", "paul", "nottelling").should be(true)
  end
  
  it "should be a more reserved login" do
    Lighthouse::Memory::fail_login
    Lighthouse::Memory::login_to("AFlight", "paul", "nottelling").should be(false)
  end
  
  it "should return nil if it can't find the project" do
    Lighthouse::Memory::find_project("some project we dont have").should be_nil
  end
  
  it "should return the project if it has it" do
    project = Lighthouse::Memory::Project.new(:name => "new")
    Lighthouse::Memory::projects << project

    Lighthouse::Memory::find_project("new").should == project
    Lighthouse::Memory::projects.delete(project)
  end
  
  it "should start with a fresnel project" do
    Lighthouse::Memory::find_project("fresnel").should_not be_nil
  end
  
  it "should add ticket to a project" do
     
    options = {:title => "test title", :description => "test description" }

    Lighthouse::Memory::add_ticket(options, @project)
    
    @project.tickets.size.should == 1
    @project.tickets[0].title.should == "test title"
    @project.tickets[0].description.should == "test description"
  end
  
  it "should have miletstones" do
    Lighthouse::Memory.milestones("fresnel").size.should == 1
    Lighthouse::Memory.milestones("fresnel")[0].title.should == "First Milestone"

    Lighthouse::Memory.milestones("fresnel") << Lighthouse::Memory::Milestone.new()

    Lighthouse::Memory.milestones("fresnel").size.should == 2
  end
  
  it "should list projects" do
    Lighthouse::Memory.projects.size.should == 1
    
    Lighthouse::Memory.projects[0].name.should == "fresnel"
  end
  
  it "should find ticket" do
    Lighthouse::Memory.add_ticket({:title => "test title", :description => "test description", :assigned_user_id => 234}, @project)
    
    @project.tickets.size.should == 1
    ticket = @project.tickets[0]
    ticket.title.should == "test title"
    ticket.description.should == "test description"    
    ticket.assigned_user_id.should == 234
  end
  
  it "should get users for a project" do
    membership = mock(Lighthouse::Memory::ProjectMembership)
    project = mock(Lighthouse::Memory::Project)
    
    project.should_receive(:memberships).and_return([membership])
    membership.should_receive(:user_id).and_return(4)
    
    Lighthouse::Memory.users_for_project(project)
  end
  
  it "should get A default user" do
    project = Lighthouse::Memory.projects[0]
    users = Lighthouse::Memory.users_for_project(project)
    
    users.size.should == 1
    users[0].name.should == "Marion"
  end
  
end
