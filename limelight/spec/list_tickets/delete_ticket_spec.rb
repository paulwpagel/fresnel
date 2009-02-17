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
  
  before(:each) do
    scene.ticket_lister.stub!(:remove_ticket)
  end
  
  it "should destroy the ticket on mouse_clicked" do
    @project.should_receive(:destroy_ticket).with(12345)
    
    click_delete
  end
  
  it "should clear the ticket from the production if the current_ticket is the deleted ticket" do    
    click_delete
    
    producer.production.current_ticket.should be_nil
  end
  
  it "should not clear the ticket from the production if it is not the deleted ticket" do
    different_ticket = mock("ticket", :id => 67890)
    producer.production.current_ticket = different_ticket
    
    click_delete
    
    producer.production.current_ticket.should == different_ticket
  end
  
  it "should tell the ticket_lister to remove the ticket from the list" do
    scene.ticket_lister.should_receive(:remove_ticket).with(12345)
    
    click_delete
  end
  
  def click_delete
    scene.find("delete_ticket_12345").mouse_clicked(nil)
  end
end