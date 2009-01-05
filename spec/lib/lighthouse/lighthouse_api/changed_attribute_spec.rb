require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/changed_attribute"

def mock_version(options={})
  diffable_attributes = mock("diffable_attributes", options)
  return mock("version", :diffable_attributes => diffable_attributes)
end

describe Lighthouse::LighthouseApi::ChangedAttribute do
  before(:each) do
    @versions = [mock_version(:name => "Old Value")]
    @attribute = Lighthouse::LighthouseApi::ChangedAttribute.new(@versions, :name, "Current Value")
  end
  
  it "should have a name" do
    @attribute.name.should == "name"
  end
  
  it "should use the value from the first version for the old value" do
    @attribute.old_value.should == "Old Value"
  end
  
  it "should give the new value from the current value if the attribute hasn't changed again" do
    @attribute.new_value.should == "Current Value"
  end
  
  it "should look ahead to the next version for the new value" do
    @versions << mock_version(:name => "New Value")
    
    @attribute.new_value.should == "New Value"
  end
  
  it "should look ahead multiple versions if the first doesn't have it" do
    @versions << mock_version(:name => nil)
    @versions << mock_version(:name => "Some Other New Value")
  
    @attribute.new_value.should == "Some Other New Value"
  end
  
end