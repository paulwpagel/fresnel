require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require 'lighthouse/memory/base'

describe Lighthouse::Memory do
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

    Lighthouse::Memory::add_ticket(options, "fresnel")
    
    Lighthouse::Memory.projects[0].tickets.size.should == 1
    Lighthouse::Memory.projects[0].tickets[0].title.should == "test title"
    Lighthouse::Memory.projects[0].tickets[0].description.should == "test description"
  end
  
  it "should throw error if it doesn't know the project" do
    lambda{Lighthouse::Memory::add_ticket({}, "fake")}.should raise_error("There is no project fake")
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
    project = Lighthouse::Memory::Project.new(:name => "new")
    Lighthouse::Memory::projects << project
    
    Lighthouse::Memory.add_ticket({:title => "test title", :description => "test description" }, "new")

    ticket = Lighthouse::Memory.ticket(project.tickets[0].id, project.id)
    ticket.title.should == "test title"
    ticket.description.should == "test description"
    Lighthouse::Memory::projects.delete(project)
  end
  
  it "should throw an error if it can't find the ticket it is looking for" do
    lambda{ticket = Lighthouse::Memory.ticket(0, 0)}.should raise_error
  end
  
  it "should get users for a project" do
    users = Lighthouse::Memory.users_for_project("fresnel")
    
    users.size.should == 1
    users[0].name.should == "Marion"
  end
  
end
