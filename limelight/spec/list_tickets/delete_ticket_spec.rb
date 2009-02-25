require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'
require "delete_ticket"

describe DeleteTicket do
  before(:each) do
    mock_lighthouse
    @ticket = mock("ticket", :id => 12345, :null_object => true)
    producer.production.current_ticket = @ticket
    @open_tickets = [@ticket]
    @project.stub!(:open_tickets).and_return(@open_tickets)
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should give an option to confirm deleting the ticket on mouse_clicked" do
    click_delete
    
    confirm_delete_ticket_prop = scene.find("confirm_delete_ticket_12345")
    confirm_delete_ticket_prop.name.should == "delete_ticket_button"
    confirm_delete_ticket_prop.players.should == "confirm_delete_ticket"
  end
  
  it "should give an option to cancel deletion of the ticket" do
    click_delete
    
    confirm_delete_ticket_prop = scene.find("cancel_delete_ticket_12345")
    confirm_delete_ticket_prop.name.should == "delete_ticket_button"
    confirm_delete_ticket_prop.players.should == "cancel_delete_ticket"
  end
  
  it "should put the confirmation inside of a wrapper prop" do
    click_delete
    
    scene.find("delete_ticket_confirmation_main").should_not be_nil
  end
  
  def click_delete
    scene.find("delete_ticket_12345").mouse_clicked(nil)
  end
end