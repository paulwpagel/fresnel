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
  
  it "should keep track of the last tickets shown" do
    call_it
    
    @player_under_test.last_tickets.should == @tickets
  end
end

describe TicketLister, "remove_ticket with real props" do
  before(:each) do
    mock_lighthouse
    @ticket = mock("ticket", :id => 12345, :null_object => true)
    @open_tickets = [@ticket]
    @project.stub!(:open_tickets).and_return(@open_tickets)
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should remove the prop" do
    scene.ticket_lister.remove_ticket(12345)
    
    scene.ticket_lister.children.should be_empty
    scene.find("ticket_12345").should be_nil
  end
end