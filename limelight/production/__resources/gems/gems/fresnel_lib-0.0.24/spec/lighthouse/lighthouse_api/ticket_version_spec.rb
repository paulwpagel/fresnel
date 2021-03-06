require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/ticket_version"

describe Lighthouse::LighthouseApi::TicketVersion do
  before(:each) do
    @diffable_attributes = mock("diffable_attributes")
    @time = Time.now
    @lighthouse_version = mock("lighthouse ticket version", :body => "Some Comment", :user_id => 12345,
                                :updated_at => @time, :diffable_attributes => @diffable_attributes)
    @project = mock("project", :id => "project_id", :user_name => nil)
    @ticket_version = Lighthouse::LighthouseApi::TicketVersion.new(@lighthouse_version, @project)
    @attribute_list = [mock("attribute")]
    changed_attributes = mock("changed_attributes", :list => @attribute_list)
    Lighthouse::LighthouseApi::ChangedAttributes.stub!(:new).and_return(changed_attributes)
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

  it "should get the timestamp from the lighthouse_version" do
    @lighthouse_version.should_receive(:updated_at).and_return(@time)
    
    @ticket_version.timestamp#.should == "Now"
  end
  
  it "should format the time" do
    @ticket_version.timestamp.should == @time.strftime("%B %d, %Y @ %I:%M %p")
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
  
  it "should have a title" do
    @lighthouse_version.stub!(:title).and_return("Current Title")
    
    @ticket_version.title.should == "Current Title"
  end
  
  it "should have state" do
    @lighthouse_version.stub!(:state).and_return("Current State")
    
    @ticket_version.state.should == "Current State"
  end
  
  it "should have a milestone_title" do
    @lighthouse_version.stub!(:milestone_id).and_return(12345)
    @project.should_receive(:milestone_title).with(12345).and_return("Milestone Title")
    
    @ticket_version.milestone_title.should == "Milestone Title"
  end
  
  it "should have an assigned user name" do
    @lighthouse_version.stub!(:assigned_user_id).and_return(67890)
    @project.should_receive(:user_name).with(67890).and_return("User Name")
    
    @ticket_version.assigned_user_name.should == "User Name"
  end
  
  it "should return the list of changed attributes" do
    @ticket_version.changed_attributes.should == @attribute_list
  end
end