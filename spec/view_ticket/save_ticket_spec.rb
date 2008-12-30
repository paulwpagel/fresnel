require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "save_ticket"

describe SaveTicket, "on_click" do
  before(:each) do
    mock_lighthouse
    @mock_ticket = mock("ticket", :title => "", :assigned_user_name => "", :state => "", :milestone_id= => nil,
          :milestone_id => 123, :description => "", :versions => [], :save => nil)
    producer.production.current_ticket = @mock_ticket
    @lighthouse_client.stub!(:milestone_id_for_title).and_return("milestone_id")
  end
  
  uses_scene :view_ticket
  
  it "should get the new milestone id from the title" do
    milestone_prop = scene.find("ticket_milestone")
    milestone_prop.choices = ["New Milestone"]
    milestone_prop.value = "New Milestone"
    @lighthouse_client.should_receive(:milestone_id_for_title).with("New Milestone")
    
    press_button
  end
  
  it "should set the milestone_id to the milestone_id from the title" do
    @mock_ticket.should_receive(:milestone_id=).with("milestone_id")
    
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
