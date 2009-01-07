require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'title_bar'

describe "title_bar" do

  before(:each) do
    mock_lighthouse
    producer.production.current_project = mock('Project', :open_tickets => [])
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @event = nil
  end
  
  it "should redirect to the add ticket scene" do
    scene.should_receive(:load).with("add_ticket")

    scene.find("add_ticket").button_pressed(@event)
  end
  
  it "should have a button to select a different project" do
    scene.find("list_projects").players.should == "title_bar"
  end
end
