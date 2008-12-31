require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "ticket_lister"

describe TicketLister, "when being told to show tickets" do

  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(TicketLister)
    @prop = mock('prop')
    ConvertsTicketToProp.stub!(:convert).and_return @prop
    
    @player_under_test.stub!(:add)
    @player_under_test.stub!(:remove_all)
    
    @tickets = [mock('ticket')]
  end
  
  def call_it
    @player_under_test.show_these_tickets(@tickets)
  end
  
  it "should make a prop for a single ticket" do    
    ConvertsTicketToProp.should_receive(:convert).with(@tickets[0])
    
    call_it
  end
  
  it "should work for multiple tickets" do
    @tickets << mock("ticket")
    
    ConvertsTicketToProp.should_receive(:convert).with(@tickets[1])
    
    call_it
  end
  
  it "should remove_all tickets before adding new tickets" do
    @player_under_test.should_receive(:remove_all).ordered
    @player_under_test.should_receive(:add).ordered
    
    call_it
  end
  
  it "should add the returned prop to itself" do
    @player_under_test.should_receive(:add).with(@prop)
    call_it
  end
  
end