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

  it "should go to the project scene when the list projects button is clicked" do
    scene.should_receive(:load).with("project")

    scene.find("project").button_pressed(@event)
  end
  
  it "should go to the list ticket scene when the list tickets button is clicked" do
    scene.should_receive(:load).with("list_tickets")

    scene.find("list_tickets").button_pressed(@event)
  end
end
