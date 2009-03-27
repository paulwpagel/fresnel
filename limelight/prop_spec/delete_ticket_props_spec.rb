require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'

describe "Delete Ticket Props" do  
  
  before(:each) do
    setup_mocks
    @ticket = mock("ticket", :id => 12345, :null_object => true)
    @open_tickets = [@ticket]
    @project.stub!(:tickets_for_type).and_return(@open_tickets)
    @project.stub!(:ticket_title).and_return(nil)
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