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
          :milestone_id => 12345, :description => "Some Description", :fresnel_versions => versions)
  end
  
  uses_scene :view_ticket
  
  it "should make a prop on the scene for the current ticket title" do    
    prop = scene.find('ticket_title')
    prop.text.should == "title"
    prop.name.should == "ticket_title"
  end
  
  it "should make a combo_box on the scene for the assigned_user_name" do
    prop = scene.find('ticket_assigned_user')
    prop.value.should == "Roger"
    prop.choices.should include("Roger")
    prop.name.should == "combo_box"
  end
  
  it "should make a prop on the scene for the ticket_state" do
    prop = scene.find('ticket_state')
    prop.text.should == "Open"
    prop.name.should == "ticket_state"
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
  
  it "should add a combo_box for the milestone_title" do
    prop = scene.find('ticket_milestone')
    prop.value.should == "Goal Two"
    prop.choices.should include("Goal Two")
    prop.name.should == "combo_box"
  end
  
  it "should include all the milstones in the choices" do
    prop = scene.find('ticket_milestone')
    prop.choices.should include("Goal One")
    prop.choices.should include("Goal Two")
  end
  
  it "should have a button to save changes to a ticket" do
    prop = scene.find('save_button')
    prop.name.should == "button"
    prop.players.should == "save_ticket"
  end
  
end
