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
  
  it "should handle errors in trying to grab the title" do
    @lighthoust_attributes.should_receive(:title).and_raise(NoMethodError)
    
    @fresnel_attributes.title.should be_nil
  end
  
  it "should have a state" do
    @lighthoust_attributes.should_receive(:state).and_return("Some State")
    @fresnel_attributes.state.should == "Some State"
  end
  
  it "should handle errors in trying to grab the state" do
    @lighthoust_attributes.should_receive(:state).and_raise(NoMethodError)
    
    @fresnel_attributes.state.should be_nil
  end
end