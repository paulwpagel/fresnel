require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "ticket_sorter"

describe TicketSorter do

  before(:each) do
    @first = ticket("a")
    @second = ticket("b")
    @third = ticket("c")
    @tickets = [@second, @third, @first]
    @mock_master = mock(TicketMaster, :show_tickets => nil, :get_tickets => @tickets)
    TicketMaster.stub!(:new).and_return(@mock_master)
  end
  
  uses_scene :list_tickets
  
  it "should get the appropriate tickets from the ticket master" do
    scene.find("ticket_type").value = "Open Tickets"
    
    @mock_master.should_receive(:get_tickets).with("Open Tickets").and_return([])
    
    scene.find("title_header").mouse_clicked(@nil)
  end
  
  it "should list the tickets by title" do
    scene.ticket_lister.should_receive(:show_these_tickets).with([@first, @second, @third])
    
    scene.find("title_header").mouse_clicked(@nil)
  end
  
  def ticket(title)
    return mock("ticket", :title => title)
  end
end