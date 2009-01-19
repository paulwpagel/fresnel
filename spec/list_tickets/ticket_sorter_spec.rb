require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "ticket_sorter"

describe TicketSorter do

  before(:each) do
    @mock_master = mock(TicketMaster, :show_tickets => nil)
    TicketMaster.stub!(:new).and_return(@mock_master)
  end
  
  uses_scene :list_tickets
  
  it "should get the appropriate tickets from the ticket master" do
    scene.find("ticket_type").value = "Open Tickets"
    
    @mock_master.should_receive(:get_tickets).with("Open Tickets")
    
    scene.find("title_header").mouse_clicked(@nil)
  end
end