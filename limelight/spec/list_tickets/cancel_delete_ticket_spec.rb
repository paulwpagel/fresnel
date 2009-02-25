require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'
require "cancel_delete_ticket"

describe CancelDeleteTicket do
  before(:each) do
    mock_lighthouse
    @ticket = mock("ticket", :id => 12345, :null_object => true)
    producer.production.current_ticket = @ticket
    @open_tickets = [@ticket]
    @project.stub!(:open_tickets).and_return(@open_tickets)
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should get rid of the confirmation box" do
    cancel_delete
    
    scene.find("delete_ticket_confirmation_box").should be_nil
  end
  
  def cancel_delete
    scene.find("delete_ticket_12345").mouse_clicked(nil)
    scene.find("cancel_delete_ticket_12345").mouse_clicked(nil)
  end
end