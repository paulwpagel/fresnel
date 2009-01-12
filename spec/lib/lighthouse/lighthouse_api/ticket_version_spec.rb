require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/ticket_version"

describe Lighthouse::LighthouseApi::TicketVersion do
  before(:each) do
    @diffable_attributes = mock("diffable_attributes")
    lighthouse_version = mock("lighthouse ticket version", :body => "Some Comment", :user_id => 12345,
                                :updated_at => "Now", :diffable_attributes => @diffable_attributes)
    @project = mock("project", :id => "project_id", :user_name => nil)
    @ticket_version = Lighthouse::LighthouseApi::TicketVersion.new(lighthouse_version, @project)
  end
  
  it "should have a comment" do
    @ticket_version.comment.should == "Some Comment"
  end
  
  it "should get the name of the user who created the version from the project" do
    @project.should_receive(:user_name).with(12345)
    
    @ticket_version.created_by
  end
  
  it "should return the found user name" do
    @project.stub!(:user_name).and_return("Some Name")
    
    @ticket_version.created_by.should == "Some Name"
  end

  it "should not crash if the user is nil" do
    Lighthouse::User.stub!(:find).and_return(nil)
    
    @ticket_version.created_by.should be_nil
  end  
  
  it "should have the timestamp" do
    @ticket_version.timestamp.should == "Now"
  end
  
  it "should make a api diffable_attributes" do
    Lighthouse::LighthouseApi::DiffableAttributes.should_receive(:new).with(@diffable_attributes, @project)
    @ticket_version.diffable_attributes
  end
  
  it "should return the created api diffable_attributes" do
    fresnel_attributes = mock(Lighthouse::LighthouseApi::DiffableAttributes)
    Lighthouse::LighthouseApi::DiffableAttributes.stub!(:new).and_return(fresnel_attributes)
    
    @ticket_version.diffable_attributes.should == fresnel_attributes
  end
end