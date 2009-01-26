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
  end

  it "should have a header for the ticket state column" do
    prop = scene.find("state_header")
    prop.name.should == "state_header"
    prop.players.should == "ticket_sorter"
  end
  
  it "should have a header for the ticket's last activity" do
    prop = scene.find("age_header")
    prop.name.should == "age_header"
    prop.players.should == "ticket_sorter"
  end

  it "should have a header for the ticket's assigned user" do
    prop = scene.find("assigned_user_header")
    prop.name.should == "assigned_user_header"
    prop.players.should == "ticket_sorter"
  end
  
  it "should have a search bar" do
    prop = scene.find("search_box")
    prop.name.should == "search_box"
    prop.players.should == "text_box"
  end
  
  it "should have a search button" do
    prop = scene.find("search_button")
    prop.players.should == "search"
  end
  
  it "should have images for asc and desc for the age column" do
    prop = scene.find("age_image")
    prop.name.should == "sort_image"
  end

  it "should have images for asc and desc for the state column" do
    prop = scene.find("state_image")
    prop.name.should == "sort_image"
  end

  it "should have images for asc and desc for the user column" do
    prop = scene.find("user_image")
    prop.name.should == "sort_image"
  end

  it "should have images for asc and desc for the title column" do
    prop = scene.find("title_image")
    prop.name.should == "sort_image"
  end
end