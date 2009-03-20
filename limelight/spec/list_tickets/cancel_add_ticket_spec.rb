require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "cancel_add_ticket"

describe CancelAddTicket do
  it "gets rid of the add ticket group when clicked" do
    @cancel_add_ticket, @scene, @production = create_player(CancelAddTicket, 
                                                :scene => {}, 
                                                :production => {})
    @cancel_add_ticket.add_ticket_group.should_receive(:remove_all)

    @cancel_add_ticket.cancel
  end
end
