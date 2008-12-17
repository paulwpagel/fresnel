require File.dirname(__FILE__) + '/../../spec_helper'
require "ticket_master"

describe TicketMaster do
  
  before(:each) do
    @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
    @tickets = [mock('ticket')]
    @project = mock("project", :all_tickets => @tickets, :open_tickets => nil)
    @client = mock("client", :find_project => @project)
    @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :lighthouse_client => @client))

    
    
    @ticket_master = TicketMaster.new(@scene)
  end
    
  it "should find the project when showing tickets" do
    @client.should_receive(:find_project).and_return(@project)
    
    @ticket_master.show_tickets("All Tickets")
  end

  it "should get all_tickets from the project if All Tickets" do
    @project.should_receive(:all_tickets)
    
    @ticket_master.show_tickets("All Tickets")
  end
  
  it "should get open_tickets from the project if Open Tickets" do
    @project.should_receive(:open_tickets)
    
    @ticket_master.show_tickets("Open Tickets")    
  end

  it "should use the ticket lister to show the tickets" do
    @ticket_lister.should_receive(:show_these_tickets).with(@tickets)

    @ticket_master.show_tickets("All Tickets")
  end
  
end