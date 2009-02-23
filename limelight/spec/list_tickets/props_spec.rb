require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'

describe "Props" do
  before(:each) do
    mock_lighthouse
    @project.stub!(:tag_names).and_return(["Tag One", "Tag Two"])
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should have a combo box that points to a type selector player" do
    prop = scene.find("ticket_type")

    prop.name.should == "combo_box"
    prop.players.should == "type_selector"
  end
  
  it "should have select project with populated " do
    prop = scene.find("project_selector")
    prop.should_not be_nil

    prop.players.should include("project_selector")
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
    prop = scene.find("assigned_user_image")
    prop.name.should == "sort_image"
  end

  it "should have images for asc and desc for the title column" do
    prop = scene.find("title_image")
    prop.name.should == "sort_image"
  end
  
  it "should have add ticket button" do
    prop = scene.find("add_ticket_button")
    prop.players.should include("create_ticket")
  end

  it "should have a tag_lister" do
    tag_lister = scene.find("tag_lister")
    tag_lister.name.should == "tag_lister"
  end

  it "should have add_ticket_group" do
    prop = scene.find("add_ticket_group")
    prop.should_not be_nil
  end
  
  it "should have an add_project prop" do
    prop = scene.find("add_project")
    prop.should_not be_nil
    prop.image.should == "images/add.png"
    prop.players.should == "add_project"
  end
end