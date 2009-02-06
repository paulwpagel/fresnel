require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "project_selector"

describe ProjectSelector do
  
  before(:each) do
    mock_lighthouse
    @project2 = create_mock_project("Two")
    @projects = [@project, @project2]
    producer.production.current_project = @project
    @lighthouse_client.stub!(:projects).and_return(@projects)
    Credential.stub!(:project_name=)
    Credential.stub!(:save)
    Credential.stub!(:save_credentials?).and_return(true)
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_lister = mock('TicketLister', :show_these_tickets => nil)
    scene.stub!(:ticket_lister).and_return(@ticket_lister)
  end
    
  it "should set the project as the current project" do
    @lighthouse_client.stub!(:find_project).and_return(@project2)
    
    scene.find("project_selector").value_changed(nil)
    
    scene.production.current_project.should == @project2
  end
  
  it "should send the ticket_lister new tickets" do
    scene.should_receive(:ticket_lister).and_return(@ticket_lister)
    @ticket_lister.should_receive(:show_these_tickets).with(@project.open_tickets)
    
    scene.find("project_selector").value_changed(nil)
  end
  
  it "should show the project's tags" do
    @lighthouse_client.should_receive(:find_project).ordered.and_return(@project2)
    scene.tag_lister.should_receive(:show_project_tags).ordered
    
    scene.find("project_selector").value_changed(nil)
  end
  
  it "should set the credentials project name to the new project name" do
    Credential.should_receive(:project_name=).with("one")
    
    scene.find("project_selector").value_changed(nil)
  end
  
  it "should save the credential" do
    Credential.should_receive(:save)
    
    scene.find("project_selector").value_changed(nil)
  end
  
  it "should not alter the credentials if the user chose not to save them" do
    Credential.stub!(:save_credentials?).and_return(false)
    Credential.should_not_receive(:project_name=)
    Credential.should_not_receive(:save)
    
    scene.find("project_selector").value_changed(nil)
  end
end