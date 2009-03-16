require File.dirname(__FILE__) + '/../spec_helper'
require "cancel_edit_ticket"

describe CancelEditTicket do
  before(:each) do
    @cancel_edit_ticket, @scene, @production = create_player(CancelEditTicket, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {})
  end

  it "should tell the ticket_lister to cancel editing the current ticket" do
    @cancel_edit_ticket.ticket_lister.should_receive(:cancel_edit_ticket)
    
    @cancel_edit_ticket.cancel
  end
end