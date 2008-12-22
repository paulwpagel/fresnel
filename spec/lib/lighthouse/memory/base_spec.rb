require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require 'lighthouse/memory/base'

describe Lighthouse::Memory do
  it "should be a promiscuous log in" do
    Lighthouse::Memory::login_to("AFlight", "paul", "nottelling").should be(true)
  end
  
  it "should return nil if it can't find the project" do
    Lighthouse::Memory::find_project("some project we dont have").should be_nil
  end
  
  it "should return the project if it has it" do
    project = mock(Lighthouse::Memory::Project, :name => "new")
    Lighthouse::Memory::projects << project

    Lighthouse::Memory::find_project("new").should == project
  end
  
  it "should start with a fresnel project" do
    Lighthouse::Memory::find_project("fresnel").should_not be_nil
  end
  
  it "should add ticket to a project" do
    options = {:title => "test title", :description => "test description", }

    Lighthouse::Memory::add_ticket(options, "fresnel")
    
    Lighthouse::Memory.projects[0].tickets.size.should == 1
    Lighthouse::Memory.projects[0].tickets[0].title.should == "test title"
    Lighthouse::Memory.projects[0].tickets[0].description.should == "test description"
  end
  
end
