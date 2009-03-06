require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "cancel_add_ticket"

describe CancelAddTicket do
  it "gets rid of the add ticket group when clicked" do
    cancel_add_ticket = Object.new
    cancel_add_ticket.extend CancelAddTicket
    @scene = mock('scene')
    cancel_add_ticket.stub!(:scene).and_return(@scene)
    @scene.should_receive(:remove_children_of).with("add_ticket_group")
    cancel_add_ticket.cancel
  end
end
