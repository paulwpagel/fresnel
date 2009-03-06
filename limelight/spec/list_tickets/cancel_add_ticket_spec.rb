require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "cancel_add_ticket"

describe CancelAddTicket do
  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should get rid of the add ticket group when clicked" do
    
    scene.find("add_ticket_button").button_pressed(nil)
    scene.find("cancel_add_ticket_button").button_pressed(nil)
    
    scene.find("add_ticket_group").children.should be_empty
  end
end
