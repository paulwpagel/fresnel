require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/diffable_attributes"

describe Lighthouse::LighthouseApi::DiffableAttributes do
  before(:each) do
    @project = mock("project", :id => "project_id")
    @lighthouse_attributes = mock("Lighthouse::DiffableAttributes")
    @fresnel_attributes = Lighthouse::LighthouseApi::DiffableAttributes.new(@lighthouse_attributes, @project)
  end

  it "should have a title" do
    @lighthouse_attributes.should_receive(:title).and_return("Some Title")
    @fresnel_attributes.title.should == "Some Title"
  end
  
  it "should handle errors in trying to grab the title" do
    @lighthouse_attributes.should_receive(:title).and_raise(NoMethodError)
    
    @fresnel_attributes.title.should be_nil
  end
  
  it "should have a state" do
    @lighthouse_attributes.should_receive(:state).and_return("Some State")
    @fresnel_attributes.state.should == "Some State"
  end
  
  it "should handle errors in trying to grab the state" do
    @lighthouse_attributes.should_receive(:state).and_raise(NoMethodError)
    
    @fresnel_attributes.state.should be_nil
  end
end

describe Lighthouse::LighthouseApi::DiffableAttributes, "assigned_user_name" do
  before(:each) do
    @project = mock("project", :id => "project_id", :user_name => nil)
    @lighthouse_attributes = mock("Lighthouse::DiffableAttributes", :assigned_user => 12345)
    @fresnel_attributes = Lighthouse::LighthouseApi::DiffableAttributes.new(@lighthouse_attributes, @project)
    @muser = mock("user", :name => "Some Name")
    Lighthouse::LighthouseApi::User.stub!(:find_by_id).and_return(@muser)
  end
    
  it "should get the name of the user from the project" do
    @project.should_receive(:user_name).with(12345)
    
    @fresnel_attributes.assigned_user_name
  end
  
  it "should return the found user name" do
    @project.stub!(:user_name).and_return("Some Name")
    
    @fresnel_attributes.assigned_user_name.should == "Some Name"
  end
    
end
describe Lighthouse::LighthouseApi::DiffableAttributes, "assigned_user_name_has_changed?" do
  before(:each) do
    @project = mock("project", :id => "project_id")
    @lighthouse_attributes = mock("Lighthouse::DiffableAttributes")
    @fresnel_attributes = Lighthouse::LighthouseApi::DiffableAttributes.new(@lighthouse_attributes, @project)
  end
  
  it "should know if the assigned_user_name_has_changed" do
    @lighthouse_attributes.should_receive(:assigned_user).and_raise(NoMethodError)
    
    @fresnel_attributes.assigned_user_name_has_changed?.should be_false
  end
  
  it "should know if the assigned_user_name_has_changed" do
    @lighthouse_attributes.stub!(:assigned_user).and_return(nil)
    
    @fresnel_attributes.assigned_user_name_has_changed?.should be_true
  end
end

describe Lighthouse::LighthouseApi::DiffableAttributes, "milestone" do
  before(:each) do
    @project = mock("project", :id => "project_id", :milestone_title => nil)
    @lighthouse_attributes = mock("Lighthouse::DiffableAttributes", :milestone => "Some Milestone Id")
    @fresnel_attributes = Lighthouse::LighthouseApi::DiffableAttributes.new(@lighthouse_attributes, @project)
  end
  
  it "should know if the milestone has changed" do
    @lighthouse_attributes.should_receive(:milestone).and_return("Some Milestone Id")
    @fresnel_attributes.milestone_title_has_changed?.should == true
  end
  
  it "should handle errors when retrieving the milestone id" do
    @lighthouse_attributes.should_receive(:milestone).and_raise(NoMethodError)
    
    @fresnel_attributes.milestone_title_has_changed?.should == false
  end

  it "should get the milestone title from the project" do
    @project.should_receive(:milestone_title).with("Some Milestone Id")
    
    @fresnel_attributes.milestone_title
  end  
  
  it "should the milestone_title" do
    @project.stub!(:milestone_title).and_return("Milestone Title")
    
    @fresnel_attributes.milestone_title.should == "Milestone Title"
  end
  
  it "should handle errors in getting the milestone title" do
    @lighthouse_attributes.should_receive(:milestone).and_raise(NoMethodError)
    
    @fresnel_attributes.milestone_title.should be_nil
  end
end