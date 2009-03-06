require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "search"

describe Search do
  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_lister = mock('ticket_lister')
    scene.stub!(:ticket_lister).and_return(@ticket_lister)
  end
  
  it "should search tickets" do
    expected_criteria = "criteria"
    scene.find("search_box").text = expected_criteria
    @ticket_lister.should_receive(:search_on).with(expected_criteria)
    scene.find("search_button").button_pressed(nil)
  end
end