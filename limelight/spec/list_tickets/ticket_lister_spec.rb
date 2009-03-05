require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
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

describe TicketLister, "cancel_edit_ticket" do
  before(:each) do
    mock_lighthouse
    @ticket = mock("ticket", :id => 12345, :null_object => true)
    @open_tickets = [@ticket]
    @project.stub!(:open_tickets).and_return(@open_tickets)
    producer.production.current_project = @project
    @lighthouse_client.stub!(:ticket).and_return(@ticket)
  end

  uses_scene :list_tickets

  before(:each) do
    edit_ticket
    scene.ticket_lister.cancel_edit_ticket
  end
  
  it "should get rid of the edit form" do    
    scene.find("save_button").should be_nil
    scene.find("cancel_edit_button").should be_nil
  end
  
  it "should re-add the ticket to the list" do
    edit_ticket
    scene.ticket_lister.cancel_edit_ticket

    ticket_prop = scene.find("ticket_12345")
    ticket_prop.players.should == "edit_ticket"
    scene.find("delete_ticket_12345").should_not be_nil
  end
  
  it "should clear the current_ticket" do
    producer.production.current_ticket.should be_nil
  end
  
  def edit_ticket
    scene.find("ticket_12345").mouse_clicked(nil)
  end
end

describe TicketLister, "search_on" do
  before(:each) do
    mock_lighthouse
    @matching_ticket = mock("ticket", :id => 12345, :matches_criteria? => true, :null_object => true)
    @non_matching_ticket = mock("ticket", :id => 12346, :matches_criteria? => false, :null_object => true)
    @tickets = [@non_matching_ticket, @matching_ticket]
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    scene.ticket_lister.show_these_tickets(@tickets)
  end

  it "adds a ticket that matches criteria" do
    scene.ticket_lister.search_on("does not matter")
    scene.find("ticket_#{@matching_ticket.id}").should_not be_nil
  end
  
  it "doesn't a ticket that doesn't match criteria" do
    scene.ticket_lister.search_on("does not matter")
    scene.find("ticket_#{@non_matching_ticket.id}").should be_nil
  end

end

describe TicketLister, "filter_by_type" do
  before(:each) do
    mock_lighthouse
    @tickets = [mock("ticket", :id => 1234, :null_object => true)]
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_master = mock("ticket_master", :tickets_for_type_and_tag => @tickets)
    scene.stub!(:ticket_master).and_return(@ticket_master)
  end
  
  it "asks ticketmaster for the tickets for given type" do
    @ticket_master.should_receive(:tickets_for_type_and_tag).with("Some Tickets", nil).and_return([])
    
    scene.ticket_lister.filter_by_type("Some Tickets")
  end
  
  it "shows the tickets returned from ticketmaster" do
    scene.ticket_lister.filter_by_type("Some Tickets")
    scene.find("ticket_1234").should_not be_nil
  end
  
end