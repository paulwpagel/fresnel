require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "save_ticket"

describe SaveTicket, "on_click" do
  before(:each) do
    mock_lighthouse
    @mock_ticket = mock("ticket", :title => "", :assigned_user_name => "", :state => "", :milestone_title= => nil,
          :milestone_id => 123, :description => "", :fresnel_versions => [], :versions => [], :save => nil)
    producer.production.current_ticket = @mock_ticket
  end
  
  uses_scene :view_ticket
  
  it "should have a button_pressed action" do
    press_button
  end
  
  it "should set the current ticket's title to the new milestone" do
    milestone_prop = scene.find("ticket_milestone")
    milestone_prop.choices = ["New Milestone"]
    milestone_prop.value = "New Milestone"
    @mock_ticket.should_receive(:milestone_title=).with("New Milestone")
    
    press_button
  end
  
  it "should save the ticket" do
    @mock_ticket.should_receive(:save)
    
    press_button
  end
  
  def press_button
    scene.find("save_button").button_pressed(nil)
  end
end
