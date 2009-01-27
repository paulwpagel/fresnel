require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "project_selector"

describe ProjectSelector do
  
  before(:each) do
    mock_lighthouse
    @project2 = mock('Project 2', :name => "Two", :open_tickets => [])
    @projects = [@project, @project2]
    producer.production.current_project = @project
    @lighthouse_client.stub!(:projects).and_return(@projects)
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
  
end