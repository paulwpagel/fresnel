require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/diffable_attributes"

describe Fresnel::DiffableAttributes do
  before(:each) do
    @lighthoust_attributes = mock("Lighthouse::DiffableAttributes")
    @fresnel_attributes = Fresnel::DiffableAttributes.new(@lighthoust_attributes)
  end
  
  it "should accept a lighthouse diffable attribute on init" do
    fresnel_attributes = Fresnel::DiffableAttributes.new(@lighthoust_attributes)
  end
  
  it "should have a title" do
    @lighthoust_attributes.should_receive(:title).and_return("Some Title")
    @fresnel_attributes.title.should == "Some Title"
  end
end