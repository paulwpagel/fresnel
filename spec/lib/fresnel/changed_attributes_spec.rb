require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/changed_attributes"

def mock_version(options={})
  diffable_attributes = mock("diffable_attributes", options)
  return mock("version", :diffable_attributes => diffable_attributes)
end

describe Fresnel::ChangedAttributes, "with no changed_attributes" do
  before(:each) do
    @version = mock_version(:title => nil, :state => nil, :assigned_user_name_has_changed? => false, :milestone_title_has_changed? => false)
    @versions = [@version]
    @ticket = mock("ticket")
  end

  it "should have no changed attributes" do
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)

    @changed_attributes.list.should == []
  end
end

describe Fresnel::ChangedAttributes, "title changed" do
  before(:each) do
    @version = mock_version(:title => "Old Title", :state => nil, :assigned_user_name_has_changed? => false, :milestone_title_has_changed? => false)
    @versions = [@version]
    @ticket = mock("ticket", :title => "Current Title")
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)
    changed_attribute = mock("changed_attribute")
    Fresnel::ChangedAttribute.should_receive(:new).with(@versions, :title, "Current Title").and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end

describe Fresnel::ChangedAttributes, "state changed" do
  before(:each) do
    @version = mock_version(:state => "Old State", :title => nil, :assigned_user_name_has_changed? => false, :milestone_title_has_changed? => false)
    @versions = [@version]
    @ticket = mock("ticket", :state => "Current State")
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)
    changed_attribute = mock("changed_attribute")
    Fresnel::ChangedAttribute.should_receive(:new).with(@versions, :state, "Current State").and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end

describe Fresnel::ChangedAttributes, "assigned user changed" do
  before(:each) do
    @version = mock_version(:state => nil, :title => nil, :assigned_user_name_has_changed? => true,
                            :assigned_user_name => "Old Assigned User Name", :milestone_title_has_changed? => false)
    @versions = [@version]
    @ticket = mock("ticket", :assigned_user_name => "Current Assigned User Name")
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)
    changed_attribute = mock("changed_attribute")
    Fresnel::ChangedAttribute.should_receive(:new).with(@versions, :assigned_user_name, "Current Assigned User Name").and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end

describe Fresnel::ChangedAttributes, "milestone title changed" do
  before(:each) do
    @version = mock_version(:state => nil, :title => nil, :milestone_title_has_changed? => true,
                            :milestone_title => "Old Milestone Title", :assigned_user_name_has_changed? => false)
    @versions = [@version]
    @ticket = mock("ticket", :milestone_title => "Current Milestone Title")
  end
  
  it "should add a new changed attribute for title" do
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)
    changed_attribute = mock("changed_attribute")
    Fresnel::ChangedAttribute.should_receive(:new).with(@versions, :milestone_title, "Current Milestone Title").and_return(changed_attribute)
    
    list = @changed_attributes.list
    list.size.should == 1
    list[0].should == changed_attribute
  end
end