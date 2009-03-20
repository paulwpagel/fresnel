require File.dirname(__FILE__) + '/spec_helper'
require "stage_info"

describe StageInfo do
  before(:each) do
    @credential = mock('credential', :project_name => "some project")
    @stage_info = StageInfo.new(:credential => @credential)
  end

  it "should have a client" do
    @stage_info.client.should == Lighthouse::LighthouseApi
  end
  
  it "should have accept a credential on init" do
    @stage_info.credential.should == @credential
  end
  
  it "should have a current_project" do
    current_project = mock('object')
    @stage_info.current_project = current_project
    @stage_info.current_project.should == current_project
  end
  
  it "should have a current_ticket" do
    current_ticket = mock('object')
    @stage_info.current_ticket = current_ticket
    @stage_info.current_ticket.should == current_ticket
  end
  
  it "should have a current_project" do
    current_project = mock('object')
    @stage_info.current_project = current_project
    @stage_info.current_project.should == current_project
  end
  
  it "should have a current_sort_order" do
    current_sort_order = mock('object')
    @stage_info.current_sort_order = current_sort_order
    @stage_info.current_sort_order.should == current_sort_order
  end
  
  it "should find the current_project on the client if it is nil" do
    @project = mock("project")
    @stage_info.current_project = nil
    
    @stage_info.client.should_receive(:find_project).with("some project").and_return(@project)
    @stage_info.current_project.should == @project
  end
end