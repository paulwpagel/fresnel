require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/changed_attributes"

def mock_version(options={})
  diffable_attributes = mock("diffable_attributes", options)
  return mock("version", :diffable_attributes => diffable_attributes)
end

describe Lighthouse::LighthouseApi::ChangedAttributes, "with no changed_attributes" do
  before(:each) do
    @version = mock_version(:title => nil, :state => nil, :assigned_user_name_has_changed? => false, :milestone_title_has_changed? => false)
  end

  it "should have no changed attributes" do
    @changed_attributes = Lighthouse::LighthouseApi::ChangedAttributes.new(@version)

    @changed_attributes.list.should == []
  end
end

describe Lighthouse::LighthouseApi::ChangedAttributes, "title changed" do
  before(:each) do
    @version = mock_version(:title => "Old Title", :state => nil, :assigned_user_name_has_changed? => false, :milestone_title_has_changed? => false)
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Lighthouse::LighthouseApi::ChangedAttributes.new(@version)
    changed_attribute = mock("changed_attribute")
    Lighthouse::LighthouseApi::ChangedAttribute.should_receive(:new).with(@version, :title).and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end

describe Lighthouse::LighthouseApi::ChangedAttributes, "state changed" do
  before(:each) do
    @version = mock_version(:state => "Old State", :title => nil, :assigned_user_name_has_changed? => false, :milestone_title_has_changed? => false)
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Lighthouse::LighthouseApi::ChangedAttributes.new(@version)
    changed_attribute = mock("changed_attribute")
    Lighthouse::LighthouseApi::ChangedAttribute.should_receive(:new).with(@version, :state).and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end

describe Lighthouse::LighthouseApi::ChangedAttributes, "assigned user changed" do
  before(:each) do
    @version = mock_version(:state => nil, :title => nil, :assigned_user_name_has_changed? => true,
                            :assigned_user_name => "Old Assigned User Name", :milestone_title_has_changed? => false)
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Lighthouse::LighthouseApi::ChangedAttributes.new(@version)
    changed_attribute = mock("changed_attribute")
    Lighthouse::LighthouseApi::ChangedAttribute.should_receive(:new).with(@version, :assigned_user_name).and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end

describe Lighthouse::LighthouseApi::ChangedAttributes, "milestone title changed" do
  before(:each) do
    @version = mock_version(:state => nil, :title => nil, :milestone_title_has_changed? => true,
                            :milestone_title => "Old Milestone Title", :assigned_user_name_has_changed? => false)
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Lighthouse::LighthouseApi::ChangedAttributes.new(@version)
    changed_attribute = mock("changed_attribute")
    Lighthouse::LighthouseApi::ChangedAttribute.should_receive(:new).with(@version, :milestone_title).and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end