require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "project_selector"

describe ProjectSelector do
  
  before(:each) do
    mock_lighthouse
    @project1 = mock('Project', :name => "One", :open_tickets => [])
    @projects = [@project1, mock('Project 2', :name => "Two", :open_tickets => [])]
    producer.production.current_project = @project1
    @lighthouse_client.stub!(:projects).and_return(@projects)
  end
  
  uses_scene :list_tickets
  
  it "should respond to value_changed" do
    @lighthouse_client.should_receive(:find_project).with("One")
    
    scene.find("project_selector").value_changed(nil)
  end
  
end