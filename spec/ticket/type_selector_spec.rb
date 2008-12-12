require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "type_selector"

describe TypeSelector, "when changing desired type" do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(TypeSelector)

    @mock_master = mock("ticket_master", :show_tickets => nil)
    @mock_scene = mock('scene', :ticket_master => @mock_master)
    @player_under_test.stub!(:scene).and_return(@mock_scene)
    @player_under_test.stub!(:value)
  end
  
  def do_call
    @player_under_test.value_changed(ignored_event=nil)
  end

  it "should ask the scene for ticket_master" do
    @mock_scene.should_receive(:ticket_master).and_return(@mock_master)
    
    do_call
  end
  
  it "should tell the ticket_master to show tickets based on value of prop" do
    expected_type = "These Tickets #{rand}"
    @player_under_test.stub!(:value).and_return(expected_type)
    @mock_master.should_receive(:show_tickets).with(expected_type)
    
    do_call
  end
end