require File.dirname(__FILE__) + '/../spec_helper'
require "cancel_delete_ticket"

describe CancelDeleteTicket do
  
  before(:each) do
    @cancel_delete_ticket, @scene, @production = create_player(CancelDeleteTicket, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {})

  end
  
  it "should get rid of the confirmation box" do
    
    @scene.should_receive(:remove).with(@cancel_delete_ticket.delete_ticket_confirmation_main)
    
    @cancel_delete_ticket.cancel
  end
end