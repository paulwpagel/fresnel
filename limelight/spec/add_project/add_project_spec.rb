require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'
require "add_project"

describe AddProject do  

  before(:each) do
    mock_lighthouse
  end
  
  uses_scene :add_project

  it "should add_project" do
    scene.find("project_name").text = "test project"
    @lighthouse_client.should_receive(:add_project).with("test project")

    scene.find("add_project_button").button_pressed(nil)
  end
  
  it "should load list tickets" do
    scene.should_receive(:load).with("list_tickets")

    scene.find("add_project_button").button_pressed(nil)    
  end
end
