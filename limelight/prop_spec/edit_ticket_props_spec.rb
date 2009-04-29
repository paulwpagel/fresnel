require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'
require "edit_ticket"

describe EditTicket do

  before(:each) do
    setup_mocks
    @project.stub!(:user_names).and_return(["Some User", "Roger", "Eric"])
    @project.stub!(:all_states).and_return(["new", "open", "resolved", "hold", "invalid"])
    @project.stub!(:milestone_titles).and_return(["Goal One", "Goal Two"])
    @project.stub!(:milestone_title).and_return("Goal Two")

    attribute_one = mock("changed_attribute", :name => "Name", :old_value => "Old Value", :new_value => "New Value")    
    version_one = mock("version", :comment => "Comment One", :created_by => "Version User One", :timestamp => "Time One", :changed_attributes => [attribute_one])
    version_two = mock("version", :comment => "Comment Two", :created_by => "Version User Two", :timestamp => "Time Two", :changed_attributes => [])
    versions = [version_one, version_two]

    @ticket = mock("ticket", :id => 12345, :title => "Title", :null_object => true, :assigned_user_name => "Roger", :state => "open",
                             :description => "Some Description", :versions => versions, :milestone_id => 12345, :tag => "one two three")
    @lighthouse_client.stub!(:ticket).and_return(@ticket)
    @project.stub!(:tickets_for_type).and_return([@ticket])
    @project.stub!(:all_tickets).and_return([@ticket])
  end

  uses_scene :list_tickets
  
  it "should have a find the ticket to click" do
    ticket = scene.find("ticket_12345")
    ticket.should_not be_nil
  end
  
  it "should remove all other props" do
    scene.find("ticket_12345").build do 
      button :text => "Save Ticket", :id => "asdfasdf", :players => "save_ticket"
    end
    
    click_ticket
    
    scene.find("asdfasdf").should be_nil
  end
  
  it "should set the current ticket on the stage_manager" do
    @lighthouse_client.should_receive(:ticket).with(12345, @project).at_least(1).times.and_return(@ticket)
    @stage_info.should_receive(:current_ticket=).with(@ticket)
    
    click_ticket
  end

  it "should make a prop on the scene for the current ticket title" do
    click_ticket
    
    prop = scene.find('ticket_title')
    prop.text.should == "Title"
    prop.name.should == "text_box"
  end
  
  it "should make a combo_box on the scene for the assigned_user_name" do
    click_ticket
    
    prop = scene.find('ticket_assigned_user')
    prop.value.should == "Roger"
    prop.name.should == "combo_box"
    prop.choices.should include("")    
    prop.choices.should include("Some User")    
    prop.choices.should include("Roger")    
    prop.choices.should include("Eric")
  end
  
  it "should make a prop on the scene for the ticket_state" do
    click_ticket

    prop = scene.find('ticket_state')
    prop.name.should == "combo_box"
    prop.value.should == "open"
    prop.choices.should == ["new", "open", "resolved", "hold", "invalid"]    
  end
  
  it "should make a prop on the scene for the ticket_description" do
    click_ticket
    
    prop = scene.find('ticket_description')
    prop.text.should == "Some Description"
    prop.name.should == "ticket_description"
  end
  
  it "should make props for one version's basic information" do
    click_ticket

    scene.find_by_name("version_created_by")[0].text.should == "Version User One"
    scene.find_by_name("version_timestamp")[0].text.should == "Time One"
    scene.find_by_name("version_comment")[0].text.should == "Comment One"
  end
  
  it "should make props for a second version" do
    click_ticket
    
    scene.find_by_name("version_created_by")[1].text.should == "Version User Two"
    scene.find_by_name("version_timestamp")[1].text.should == "Time Two"
    scene.find_by_name("version_comment")[1].text.should == "Comment Two"
  end
  
  it "should not include the wrapper for ticket versions if there are none" do
    @ticket.stub!(:versions).and_return([])
    click_ticket
    
    scene.find_by_name("secondary_ticket_group").should be_empty
  end
  
  it "should include the change message for a version" do
    click_ticket
    
    prop = scene.find_by_name("version_changed_attribute")[0]
    prop.text.should include("Name")
    prop.text.should include("Old Value")
    prop.text.should include("New Value")
  end
  
  it "should add a combo_box for the milestone_title" do
    click_ticket
    
    prop = scene.find('ticket_milestone')
    prop.value.should == "Goal Two"
    prop.choices.should include("Goal One")
    prop.choices.should include("Goal Two")
    prop.choices.should include("")
    prop.name.should == "combo_box"
  end
  
  it "should have a place to enter a comment" do
    click_ticket
    
    prop = scene.find("ticket_comment")
    prop.name.should == "text_area"
  end
  
  it "should have a button to save changes to a ticket" do
    click_ticket
    
    prop = scene.find('save_button')
    prop.name.should == "button"
    prop.players.should == "save_ticket"
  end
  
  it "should have a button to cancel changes" do
    click_ticket
    
    prop = scene.find('cancel_edit_button')
    prop.name.should == "button"
    prop.players.should == "cancel_edit_ticket"
  end
  
  it "should display a ticket's tags" do
    click_ticket
    
    prop = scene.find('ticket_tag')
    prop.name.should == "text_box"
    prop.text.should include("one two three")
  end
    
  def click_ticket
    scene.find("ticket_12345").mouse_clicked(nil)
  end
end

