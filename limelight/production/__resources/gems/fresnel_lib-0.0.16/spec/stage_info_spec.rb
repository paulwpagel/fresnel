require File.dirname(__FILE__) + '/spec_helper'
require "stage_info"

describe StageInfo do
  before(:each) do
    @credential = mock('credential')
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
  
end