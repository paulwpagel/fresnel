require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/user"

describe Lighthouse::LighthouseApi::User do
  before(:each) do
    @muser = mock("user", :name => "some user")
    Lighthouse::User.stub!(:find).and_return(@muser)
  end
  it "should find a lighthouse user" do
    Lighthouse::User.should_receive(:find).with(12345)
    
    Lighthouse::LighthouseApi::User.find_by_id(12345)
  end
  
  it "should return the found user if successful" do
    Lighthouse::LighthouseApi::User.find_by_id(12345).should == @muser
  end
  
  it "should return nil if it cannot find the user" do
    response = mock('unauthorized', :code => "500 Internal Server Error")
    Lighthouse::User.stub!(:find).and_raise(ActiveResource::ServerError.new(response))
    
    Lighthouse::LighthouseApi::User.find_by_id(12345).should be_nil
  end
  
  it "should find the user for a given id" do
    Lighthouse::User.should_receive(:find).with(12345)
    
    Lighthouse::LighthouseApi::User.user_name_for_id(12345)
  end
  
  it "should return the user's name if the user was found" do
    Lighthouse::LighthouseApi::User.user_name_for_id(12345).should == "some user"
  end
  
  it "should return nil for the user name if it cannot find the user" do
    response = mock('unauthorized', :code => "500 Internal Server Error")
    Lighthouse::User.stub!(:find).and_raise(ActiveResource::ServerError.new(response))
    
    Lighthouse::LighthouseApi::User.user_name_for_id(12345).should be_nil
  end
end