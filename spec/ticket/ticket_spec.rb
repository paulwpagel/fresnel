require File.dirname(__FILE__) + '/../spec_helper'
require 'ticket'

describe Ticket do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(Ticket)
  end
  
  it "should have a ticket_master" do
    ticket_master = mock('ticket_master')
    TicketMaster.should_receive(:new).with(@player_under_test).and_return(ticket_master)
    
    @player_under_test.ticket_master.should == ticket_master
  end
  
end