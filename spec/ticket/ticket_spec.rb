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

describe Ticket, "view_ticket" do
  
  class Production
    attr_accessor :current_ticket
  end
  
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(Ticket)
    @scene = mock("scene", :load => nil)
    @player_under_test.stub!(:scene).and_return(@scene)

    production = Production.new
    @player_under_test.stub!(:production).and_return(production)
    
    @project = mock("project", :open_tickets => [])
    @lighthouse_client = mock(LighthouseClient, :find_project => @project)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
  end
  
  it "should have a view method shows a ticket" do
    @scene.should_receive(:load).with("view_ticket")
    
    @player_under_test.view(4)
  end
  
  it "should find the ticket with an id on view" do
    @lighthouse_client.should_receive(:find_project).with(anything()).and_return(@project)
    
    @player_under_test.view('asdf')
  end
  
  it "should get the ticket with the proper id from the project" do
    ticket_one = mock("ticket", :id => 123)
    ticket_two = mock("ticket", :id => 456)
    @project.stub!(:open_tickets).and_return([ticket_one, ticket_two])
    
    @player_under_test.view(456)
    
    @player_under_test.production.current_ticket.should == ticket_two
  end
  
end