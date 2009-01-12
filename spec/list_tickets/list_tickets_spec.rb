require File.dirname(__FILE__) + '/../spec_helper'
require 'list_tickets'

describe ListTickets do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(ListTickets)
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

describe ListTickets, "view_ticket" do
  
  class Production
    attr_accessor :current_ticket, :lighthouse_client, :current_project
  end
  
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(ListTickets)
    @scene = mock("scene", :load => nil)
    @player_under_test.stub!(:scene).and_return(@scene)

    production = Production.new
    @player_under_test.stub!(:production).and_return(production)
    
    @ticket = mock("ticket")    
    @lighthouse_client = mock("LighthouseClient", :ticket => @ticket)
    production.lighthouse_client = @lighthouse_client
    
    @current_project = mock("project", :id => "project_id")
    production.current_project = @current_project
  end
  
  it "should have a view method shows a ticket" do
    @scene.should_receive(:load).with("view_ticket")
    
    @player_under_test.view(4)
  end
  
  it "should find the ticket with an id on view" do
    @lighthouse_client.should_receive(:ticket).with(1234, @current_project)
    
    @player_under_test.view(1234)
  end
  
  it "should get the ticket with the proper id from the project" do
    @player_under_test.view("ticket_id")
    
    @player_under_test.production.current_ticket.should == @ticket
  end
  
end