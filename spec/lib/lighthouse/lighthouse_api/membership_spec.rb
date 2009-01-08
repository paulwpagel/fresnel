require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/membership"

describe Lighthouse::LighthouseApi::Membership do

  before(:each) do
    Lighthouse::Membership.stub!(:find).and_return([])
  end
  
  it "should find all memberships for a project with a given id" do
    Lighthouse::Membership.should_receive(:find).with(:all, :params => {:project_id => 123}).and_return([])
    
    Lighthouse::LighthouseApi::Membership.all_user_names(123)
  end
  
  it "should get the user name for one membership" do
    membership_one = mock("membership", :user_id => "user id one")
    Lighthouse::Membership.stub!(:find).and_return([membership_one])
    Lighthouse::LighthouseApi::User.should_receive(:user_name_for_id).with("user id one").and_return("user one")
    
    Lighthouse::LighthouseApi::Membership.all_user_names(123).should == ["user one"]
  end
  
  it "should get the user name for two memberships" do
    membership_one = mock("membership", :user_id => "user id one")
    membership_two = mock("membership", :user_id => "user id two")
    Lighthouse::Membership.stub!(:find).and_return([membership_one, membership_two])
    Lighthouse::LighthouseApi::User.stub!(:user_name_for_id).and_return("user one", "user two")
    
    Lighthouse::LighthouseApi::Membership.all_user_names(123).should == ["user one", "user two"]
  end
end
