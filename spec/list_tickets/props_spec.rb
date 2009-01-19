require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'

describe "Props" do
  before(:each) do
    mock_lighthouse
    producer.production.current_project = mock('Project', :open_tickets => [])
  end
  
  uses_scene :list_tickets
  
  it "should have a combo box that points to a type selector player" do
    prop = scene.find("ticket_type")

    prop.name.should == "combo_box"
    prop.players.should == "type_selector"
  end
  
  it "should have a ticket_list" do
    prop = scene.find("ticket_lister")

    prop.name.should == "ticket_lister"
  end
  
  it "should have a header for the ticket title column" do
    prop = scene.find("title_header")
    prop.name.should == "title_header"
    prop.players.should == "ticket_sorter"
    prop.text.should == "Title"
  end

  it "should have a header for the ticket state column" do
    prop = scene.find("state_header")
    prop.name.should == "state_header"
    prop.players.should == "ticket_sorter"
    prop.text.should == "State"
  end
end