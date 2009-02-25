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
    scene.find("public").text = "True"
    @lighthouse_client.should_receive(:add_project).with({:name => "test project", :public => "True"})

    scene.find("add_project_button").button_pressed(nil)
  end
  
  it "should load list tickets" do
    scene.find("project_name").text = "test project"
    scene.should_receive(:load).with("list_tickets")

    scene.find("add_project_button").button_pressed(nil)    
  end
  
  it "should not allow a blank project to be added" do
    scene.find("project_name").text = ""
    
    scene.find("add_project_button").button_pressed(nil)
    
    scene.find("error_message").text.should == "Please enter a project name"
  end
end
