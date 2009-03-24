require File.dirname(__FILE__) + '/spec_helper'
require "stage_info"

describe StageInfo do
  before(:each) do
    @credential = mock('credential', :project_name => "some project", :project_name= => nil)
    @client = mock("client")
    @stage_manager = mock("stage_manager")
    @stage_info = StageInfo.new(:credential => @credential, :stage_manager => @stage_manager, :name => "stage name")
    @project = mock("project", :name => "project name")
  end
  
  it "should have accept a credential on init" do
    @stage_info.credential.should == @credential
  end

  it "should have a current_ticket" do
    current_ticket = mock('object')
    @stage_info.current_ticket = current_ticket
    @stage_info.current_ticket.should == current_ticket
  end
  
  it "should have a current_project" do
    @stage_info.current_project = @project
    @stage_info.current_project.should == @project
  end
  
  it "should update the credential when changing the current_project" do
    @credential.should_receive(:project_name=).with("project name")
    
    @stage_info.current_project = @project
  end
  
  it "should have a current_sort_order" do
    current_sort_order = mock('object')
    @stage_info.current_sort_order = current_sort_order
    @stage_info.current_sort_order.should == current_sort_order
  end
  
  it "should find the current_project from the client if it is nil" do
    @stage_info.current_project = nil
    
    @stage_manager.should_receive(:client_for_stage).with("stage name").and_return(@client)
    @client.should_receive(:find_project).with("some project").and_return(@project)
    @stage_info.current_project.should == @project
  end
  
  it "should have a method to return the current_project_name" do
    @stage_info.current_project_name.should == "some project"
  end
  
  describe "when resesting" do
    it "should clear the credential" do
      @stage_info.reset

      @stage_info.credential.should be_nil
    end
    
    it "should have no current_ticket" do
      @stage_info.current_ticket = "some ticket"
      @stage_info.reset
      
      @stage_info.current_ticket.should be_nil
    end

    it "should have no current_project_name" do
      @stage_info.reset
      
      @stage_info.current_project_name.should be_nil
    end
    
    it "should have no current_sort_order" do
      @stage_info.current_sort_order = "ascending"
      @stage_info.reset
      
      @stage_info.current_sort_order.should be_nil
    end
  end
end