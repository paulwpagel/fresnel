require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/ticket_version"

describe Fresnel::TicketVersion do
  before(:each) do
    @diffable_attributes = mock("diffable_attributes")
    lighthouse_version = mock("lighthouse ticket version", :body => "Some Comment", :user_id => 12345,
                                :updated_at => "Now", :diffable_attributes => @diffable_attributes)
    @ticket_version = Fresnel::TicketVersion.new(lighthouse_version)
    
    @user = mock("user", :name => "Someone")
    Lighthouse::User.stub!(:find).and_return(@user)
  end
  
  it "should have a comment" do
    @ticket_version.comment.should == "Some Comment"
  end
  
  it "should find the user who made the version" do
    Lighthouse::User.should_receive(:find).with(12345)
    
    @ticket_version.user
  end

  it "should return the name of the user" do    
    @ticket_version.created_by.should == "Someone"
  end

  it "should not crash if the user is nil" do
    Lighthouse::User.stub!(:find).and_return(nil)
    
    @ticket_version.created_by.should == ""
  end  
  
  it "should find a user" do
    Lighthouse::User.should_receive(:find).with(12345).and_return(@user)
    
    @ticket_version.user.should == @user
  end
  
  it "should return nil if it fails to find a user" do
    error = ActiveResource::ResourceNotFound.new(mock('resource not found', :code => "Failed with 404 Not Found"))
    Lighthouse::User.should_receive(:find).and_raise(error)
    
    @ticket_version.user.should == nil
  end
  
  it "should have the timestamp" do
    @ticket_version.timestamp.should == "Now"
  end
  
  it "should make a fresnel diffable_attributes" do
    Fresnel::DiffableAttributes.should_receive(:new).with(@diffable_attributes)
    @ticket_version.diffable_attributes
  end
  
  it "should return the created fresnel diffable_attributes" do
    fresnel_attributes = mock(Fresnel::DiffableAttributes)
    Fresnel::DiffableAttributes.stub!(:new).and_return(fresnel_attributes)
    
    @ticket_version.diffable_attributes.should == fresnel_attributes
  end
end