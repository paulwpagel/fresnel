require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "add_project"

describe AddProject do

  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
  end

  uses_scene :list_tickets
  
  it "should send it to the add_project scene" do
    scene.should_receive(:load).with("add_project")

    scene.find("add_project").mouse_clicked(nil)
  end

end