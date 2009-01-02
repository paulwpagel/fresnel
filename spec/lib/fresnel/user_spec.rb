require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/user"

describe Fresnel::User do
  before(:each) do
    @muser = mock("user")
    Lighthouse::User.stub!(:find).and_return(@muser)
  end
  it "should find a lighthouse user" do
    Lighthouse::User.should_receive(:find).with(12345)
    
    Fresnel::User.find_by_id(12345)
  end
  
  it "should return the found user if successful" do
    Fresnel::User.find_by_id(12345).should == @muser
  end
  
  it "should return nil if it cannot find the user" do
    response = mock('unauthorized', :code => "500 Internal Server Error")
    Lighthouse::User.stub!(:find).and_raise(ActiveResource::ServerError.new(response))
    
    Fresnel::User.find_by_id(12345).should be_nil
  end
end