require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/changed_attribute"

describe Lighthouse::LighthouseApi::ChangedAttribute do
  before(:each) do
    diffable_attributes = mock("diffable_attributes", :attribute => "Old Value")
    @version = mock("version", :diffable_attributes => diffable_attributes, :attribute => "Current Value")
    @attribute = Lighthouse::LighthouseApi::ChangedAttribute.new(@version, :attribute)
  end
  
  it "should have a name" do
    @attribute.name.should == "attribute"
  end
  
  it "should use the value from the first version diffable attributes" do
    @attribute.old_value.should == "Old Value"
  end
  
  it "should give the new value from the first version" do
    @attribute.new_value.should == "Current Value"
  end
  
end