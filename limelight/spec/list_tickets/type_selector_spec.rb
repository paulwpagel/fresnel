require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "type_selector"

describe TypeSelector, "when changing desired type" do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(TypeSelector)

    @mock_lister = mock("ticket_lister", :filter_by_type => nil)
    @mock_scene = mock('scene', :ticket_lister => @mock_lister)
    @player_under_test.stub!(:scene).and_return(@mock_scene)
    @player_under_test.stub!(:value)
  end
  
  it "should tell the ticket_lister to show tickets based on value of prop" do
    expected_type = "These Tickets #{rand}"
    @player_under_test.stub!(:value).and_return(expected_type)
    @mock_lister.should_receive(:filter_by_type).with(expected_type)
    
    @player_under_test.notify_ticket_lister
  end
end