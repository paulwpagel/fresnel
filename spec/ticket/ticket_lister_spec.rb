require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "ticket_lister"

describe TicketLister, "when being told to show tickets" do

  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(TicketLister)
    @prop = mock('prop')
    ConvertsTicketToProp.stub!(:convert).and_return @prop
    
    @ticket_list_container = mock('container', :add => nil)
    @scene= mock("scene", :find => @ticket_list_container)
    @player_under_test.stub!(:scene).and_return @scene
    
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
  
  it "should use the ticket_list container" do
    @scene.should_receive(:find).with("ticket_list_container").and_return(@ticket_list_container)
    
    call_it
  end
  
  it "should add the returned prop to the ticket_list container" do
    @ticket_list_container.should_receive(:add).with(@prop)
    call_it
  end
  
end