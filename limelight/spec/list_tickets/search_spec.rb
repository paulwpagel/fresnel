require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "search"

describe Search do
  before(:each) do
    mock_lighthouse
    @ticket1 = mock(Lighthouse::LighthouseApi::Ticket)
    @ticket2 = mock(Lighthouse::LighthouseApi::Ticket)
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_lister = mock('ticket_lister', :last_tickets => [@ticket1, @ticket2])
    scene.stub!(:ticket_lister).and_return(@ticket_lister)
  end
  
  it "should search tickets" do
    scene.find("search_box").text = "criteria"

    @ticket1.should_receive(:matches_criteria?).with("criteria").and_return(true)
    @ticket2.should_receive(:matches_criteria?).with("criteria").and_return(false)
    
    @ticket_lister.should_receive(:show_these_tickets).with([@ticket1])
    scene.find("search_button").button_pressed(nil)
  end
end