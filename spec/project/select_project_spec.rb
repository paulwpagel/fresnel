require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "select_project"

describe SelectProject, "scene opened" do
  
  before(:each) do
    mock_lighthouse
    @projects = [mock('Project', :name => "One"), mock('Project', :name => "Two")]
    @lighthouse_client.stub!(:projects).and_return(@projects)
  end

  uses_scene :project
  
  before(:each) do
    scene.stub!(:load)
  end

  it "should load up and set the current project" do
    lighthouse_project = mock('lighthouse project')
    @lighthouse_client.should_receive(:find_project).with("One").and_return(lighthouse_project)
    
    project_one = scene.find("One")
    project_one.mouse_clicked(nil)
    
    producer.production.current_project.should == lighthouse_project
  end
  
  it "should load up the view_ticket scene" do
    @lighthouse_client.stub!(:find_project)
    scene.should_receive(:load).with("list_tickets")

    scene.find("One").mouse_clicked(nil)
  end
end