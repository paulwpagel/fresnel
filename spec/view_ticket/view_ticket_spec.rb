require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "view_ticket"

describe ViewTicket, "load_current_ticket" do
  
  before(:each) do
    mock_lighthouse
    @lighthouse_client.stub!(:milestone_title).and_return("Goal Two")
    mock_project = mock("project", :milestone_titles => ["Goal One", "Goal Two"])
    @lighthouse_client.stub!(:find_project).and_return(mock_project)
    version_one = mock("version", :comment => "Comment One", :created_by => "Version User One", :timestamp => "Time One")
    version_two = mock("version", :comment => "Comment Two", :created_by => "Version User Two", :timestamp => "Time Two")
    versions = [version_one, version_two]
    producer.production.current_ticket = mock("ticket", :title => 'title', :assigned_user_name => "Roger", :state => "open",
          :milestone_id => 12345, :description => "Some Description", :versions => versions)
    attribute_one = mock("changed_attribute", :name => "Name", :old_value => "Old Value", :new_value => "New Value")
    producer.production.current_ticket.stub!(:changed_attributes_for_version).and_return([attribute_one])
    
    @current_project = mock("project", :all_states => ["new", "open", "resolved", "hold", "invalid"])
    producer.production.current_project = @current_project
  end
  
  uses_scene :view_ticket
  
  it "should make a prop on the scene for the current ticket title" do    
    prop = scene.find('ticket_title')
    prop.text.should == "title"
    prop.name.should == "text_box"
  end
  
  it "should make a combo_box on the scene for the assigned_user_name" do
    prop = scene.find('ticket_assigned_user')
    prop.value.should == "Roger"
    prop.choices.should include("Roger")
    prop.name.should == "combo_box"
  end
  
  it "should make a prop on the scene for the ticket_state" do
    prop = scene.find('ticket_state')
    prop.name.should == "combo_box"
    prop.value.should == "open"
  end

  it "should get the choices from the current project" do
    prop = scene.find('ticket_state')
    prop.choices.should == ["new", "open", "resolved", "hold", "invalid"]    
  end
  
  it "should make a prop on the scene for the ticket_description" do
    prop = scene.find('ticket_description')
    prop.text.should == "Some Description"
    prop.name.should == "ticket_description"
  end

  it "should make props for one version" do
    prop = scene.find('ticket_version_1')
    prop.text.should include("Comment One")
    prop.text.should include("Version User One")
    prop.text.should include("Time One")
  end
  
  it "should make props for a second version" do
    prop = scene.find('ticket_version_2')
    prop.text.should include("Comment Two")
    prop.text.should include("Version User Two")
    prop.text.should include("Time Two")
  end
  
  it "should include the change message for a version" do
    prop = scene.find("ticket_version_1")
    prop.text.should include("Name")
    prop.text.should include("Old Value")
    prop.text.should include("New Value")
  end
  
  it "should add a combo_box for the milestone_title" do
    prop = scene.find('ticket_milestone')
    prop.value.should == "Goal Two"
    prop.choices.should include("Goal Two")
    prop.name.should == "combo_box"
  end
  
  it "should include all the milestones in the choices" do
    prop = scene.find('ticket_milestone')
    prop.choices.should include("Goal One")
    prop.choices.should include("Goal Two")
  end
  
  it "should inclue an empty option in the milestone choices" do
    prop = scene.find('ticket_milestone')
    prop.choices.should include("")
  end
  
  it "should have a place to enter a comment" do
    prop = scene.find("ticket_comment")
    prop.name.should == "text_box"
  end
  
  it "should have a button to save changes to a ticket" do
    prop = scene.find('save_button')
    prop.name.should == "button"
    prop.players.should == "save_ticket"
  end
  
end
