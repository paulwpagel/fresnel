require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/changed_attribute"

describe Fresnel::ChangedAttribute do
  it "should have a name" do
    attribute = Fresnel::ChangedAttribute.new(:name => "Some Name")
    attribute.name.should == "Some Name"
  end
  
  it "should have an old value" do
    attribute = Fresnel::ChangedAttribute.new(:old_value => "Old Value")
    attribute.old_value.should == "Old Value"
  end

  it "should have a new value" do
    attribute = Fresnel::ChangedAttribute.new(:new_value => "New Value")
    attribute.new_value.should == "New Value"
  end
  
  it "should accept no input params" do
    attribute = Fresnel::ChangedAttribute.new
    attribute.name.should be_nil
    attribute.old_value.should be_nil
    attribute.new_value.should be_nil
  end
end