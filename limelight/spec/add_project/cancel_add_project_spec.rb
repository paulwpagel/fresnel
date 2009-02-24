require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'
require "cancel_add_project"

describe CancelAddProject do  

  before(:each) do
    mock_lighthouse
  end
  
  uses_scene :add_project

  it "should show list tickets scene" do
    scene.should_receive(:load).with("list_tickets")
    
    scene.find("cancel_add_project_button").button_pressed(nil)
  end
  
end
