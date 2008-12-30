require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "save_ticket"

describe SaveTicket, "on_click" do
  before(:each) do
    mock_lighthouse
    @mock_ticket = mock("ticket", :title => "", :assigned_user_name => "", :state => "", :title= => nil,
          :milestone_id => 123, :description => "", :versions => [], :save => nil)
    producer.production.current_ticket = @mock_ticket
  end
  
  uses_scene :view_ticket
  
  # it "should set the new milestone id for the ticket" do
  #   milestone_prop = scene.find("ticket_milestone")
  #   milestone_prop.choices = ["12345"]
  #   milestone_prop.value = "12345"
  #   @mock_ticket.should_receive(:milestone_id=).with(12345)
  #   
  #   press_button
  # end
  
  it "should set the ticket's title" do
    milestone_prop = scene.find("ticket_title")
    milestone_prop.text = "New Title"
    @mock_ticket.should_receive(:title=).with("New Title")
   
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
