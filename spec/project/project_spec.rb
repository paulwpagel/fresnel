require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "project"

describe Project, "scene opened" do

  before(:each) do
    mock_lighthouse
    @projects = [mock('Project', :name => "One"), mock('Project', :name => "Two")]
    @lighthouse_client.stub!(:projects).and_return(@projects)
  end

  uses_scene :project

  it "should have list of projects" do
    
    one = scene.find("One")
    one.should_not be_nil
    one.text.should == "One"
    one.players.should include("select_project")
    
    two = scene.find("Two")
    two.should_not be_nil
    two.text.should == "Two"
    two.players.should include("select_project")
  end
  
end