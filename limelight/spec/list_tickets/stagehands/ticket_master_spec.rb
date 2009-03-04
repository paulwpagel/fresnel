require File.dirname(__FILE__) + '/../../spec_helper'
require "ticket_master"

describe TicketMaster, "filter_by_type" do
  
  before(:each) do
    @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
    @tickets = [mock('ticket')]
    @project = mock("project", :all_tickets => @tickets, :open_tickets => nil)
    @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :current_project => @project))
    
    @ticket_master = TicketMaster.new(@scene)
  end
    
  it "should get all_tickets from the project if All Tickets" do
    @project.should_receive(:all_tickets)
    
    @ticket_master.filter_by_type("All Tickets")
  end
  
  it "should get open_tickets from the project if Open Tickets" do
    @project.should_receive(:open_tickets)
    
    @ticket_master.filter_by_type("Open Tickets")    
  end

  it "should use the ticket lister to show the tickets" do
    @ticket_lister.should_receive(:show_these_tickets).with(@tickets)

    @ticket_master.filter_by_type("All Tickets")
  end
  
  it "should not crash if the ticket_lister is not on the screen" do
    @scene.stub!(:ticket_lister).and_return(nil)
    
    lambda{@ticket_master.filter_by_type("Some Tickets")}.should_not raise_error
  end
end

describe TicketMaster, "filter_by_tag" do
  before(:each) do
    @tickets = [mock('ticket')]
    @project = mock("project", :tickets_for_tag => @tickets)
    @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
    @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :current_project => @project))
    
    @ticket_master = TicketMaster.new(@scene)
  end
  
  it "should have a filter_by_tag method" do
    @ticket_master.filter_by_tag("some tag")
  end

  it "should get the tickets to show from the current_project" do
    @project.should_receive(:tickets_for_tag).with("Tag One").and_return([])
    
    @ticket_master.filter_by_tag("Tag One")
  end
  
  it "should show the found tickets" do
    @ticket_lister.should_receive(:show_these_tickets).with(@tickets)
    
    @ticket_master.filter_by_tag("Tag One")
  end
  
  it "should not crash if the ticket_lister is not on the screen" do
    @scene.stub!(:ticket_lister).and_return(nil)
    
    lambda{@ticket_master.filter_by_tag("Tag One")}.should_not raise_error
  end
end

describe TicketMaster, "get_tickets" do
  before(:each) do
    @tickets = [mock('ticket')]
    @project = mock("project", :all_tickets => nil, :open_tickets => nil)
    @scene = mock("scene", :production => mock("production", :current_project => @project))
    
    @ticket_master = TicketMaster.new(@scene)
  end
    
  it "should get all_tickets from the project if All Tickets" do
    @project.should_receive(:all_tickets)
    
    @ticket_master.get_tickets("All Tickets")
  end
  
  it "should get open_tickets from the project if Open Tickets" do
    @project.should_receive(:open_tickets)
    
    @ticket_master.get_tickets("Open Tickets")    
  end
  
  it "should return the found tickets" do
    @project.stub!(:open_tickets).and_return(@tickets)
    
    @ticket_master.get_tickets("Open Tickets").should == @tickets
  end
end
