require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "search"

describe Search do
  before(:each) do
    mock_lighthouse
    @ticket1 = mock(Lighthouse::LighthouseApi::Ticket)
    @ticket2 = mock(Lighthouse::LighthouseApi::Ticket)
    @project.stub!(:all_tickets).and_return([@ticket1, @ticket2])
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should search tickets" do
    ticket_lister = mock('ticket_lister')
    scene.find("search_box").text = "criteria"

    @ticket1.should_receive(:matches_criteria?).with("criteria").and_return(true)
    @ticket2.should_receive(:matches_criteria?).with("criteria").and_return(false)
    
    scene.should_receive(:ticket_lister).and_return(ticket_lister)
    ticket_lister.should_receive(:show_these_tickets).with([@ticket1])
    scene.find("search_button").button_pressed(nil)
  end
end