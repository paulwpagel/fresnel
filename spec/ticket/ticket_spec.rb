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
  
  it "should have a ticket_lister" do
    scene = mock('scene')
    @player_under_test.stub!(:scene).and_return(scene)
    lister = mock('lister')
    scene.should_receive(:find).with("ticket_lister").and_return(lister)
    
    @player_under_test.ticket_lister.should == lister
  end
    
end