require File.dirname(__FILE__) + '/../spec_helper'
require "cancel_edit_ticket"

describe CancelEditTicket do
  before(:each) do
    mock_lighthouse
    @ticket = mock("ticket", :id => 12345, :null_object => true)
    @open_tickets = [@ticket]
    @project.stub!(:open_tickets).and_return(@open_tickets)
    producer.production.current_project = @project
    @lighthouse_client.stub!(:ticket).and_return(@ticket)
  end

  uses_scene :list_tickets

  it "should tell the ticket_lister to cancel editing the current ticket" do
    scene.ticket_lister.should_receive(:cancel_edit_ticket)
    
    scene.find("ticket_12345").mouse_clicked(nil)
    scene.find("cancel_edit_button").button_pressed(nil)
  end
end