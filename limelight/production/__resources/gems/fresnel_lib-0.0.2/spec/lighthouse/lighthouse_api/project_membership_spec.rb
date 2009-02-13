require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/project_membership"

describe Lighthouse::LighthouseApi::ProjectMembership do

  before(:each) do
    Lighthouse::ProjectMembership.stub!(:find).and_return([])
  end
  
  it "should find all memberships for a project with a given id" do
    Lighthouse::ProjectMembership.should_receive(:find).with(:all, :params => {:project_id => 123}).and_return([])
    
    Lighthouse::LighthouseApi::ProjectMembership.all_users_for_project(123)
  end
  
  it "should get the user for one membership" do
    membership_one = mock("membership", :user_id => "user id one")
    Lighthouse::ProjectMembership.stub!(:find).and_return([membership_one])
    user_one = mock("user")
    Lighthouse::LighthouseApi::User.should_receive(:find_by_id).with("user id one").and_return(user_one)
     
    Lighthouse::LighthouseApi::ProjectMembership.all_users_for_project(123).should == [user_one]
  end
  
  it "should get the user name for two memberships" do
    membership = mock("membership", :user_id => "user id")
    Lighthouse::ProjectMembership.stub!(:find).and_return([membership, membership])
    user_one = mock("user")
    user_two = mock("user")
    Lighthouse::LighthouseApi::User.stub!(:find_by_id).and_return(user_one, user_two)
    
    Lighthouse::LighthouseApi::ProjectMembership.all_users_for_project(123).should == [user_one, user_two]
  end
end
