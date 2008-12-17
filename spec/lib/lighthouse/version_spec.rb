require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/version"

describe Lighthouse::Ticket::Version do
  before(:each) do
    @version = Lighthouse::Ticket::Version.new
    @version.stub!(:user_id).and_return(12345)
    user = mock("user", :name => "Someone")
    Lighthouse::User.stub!(:find).and_return(user)
  end
  
  it "should find the user who made the version" do
    Lighthouse::User.should_receive(:find).with(12345)
    
    @version.created_by
  end
  
  it "should return the name of the user" do    
    @version.created_by.should == "Someone"
  end
  
  it "should have a comment" do
    @version.stub!(:body).and_return("Some Comment")
    
    @version.comment.should == "Some Comment"
  end
  
  it "should handle no user" do
    # ActiveResource::ResourceNotFound: Failed with 404 Not Found
    error = ActiveResource::ResourceNotFound.new(mock('resource not found', :code => "Failed with 404 Not Found"))
    Lighthouse::User.should_receive(:find).and_raise(error)
    
    @version.created_by.should == ""
  end
  
  it "should not fail if the user is nil" do
    Lighthouse::User.stub!(:find).and_return(nil)
    
    @version.created_by.should == ""
  end
end