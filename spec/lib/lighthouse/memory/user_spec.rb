require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/memory/user"
require "lighthouse/lighthouse"

describe Lighthouse::User do
  it "should exist" do
    Lighthouse::User.new
  end
  
  it "should have basic user informartion" do
    user = Lighthouse::User.new(:name => "Eric", :id => "User ID")

    user.name.should == "Eric"
    user.id.should == "User ID"
  end
end
