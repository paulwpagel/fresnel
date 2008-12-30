require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/milestone"

describe Fresnel::Milestone, "initialize" do
  it "should accept a lighthouse milestone on init" do
    @lighthouse_milestone = mock(Lighthouse::Milestone)
    Fresnel::Milestone.new(@lighthouse_milestone)
  end
end

describe Fresnel::Milestone, "find" do  
  before(:each) do
    @lighthouse_milestone = mock(Lighthouse::Milestone)
    Lighthouse::Milestone.stub!(:find).and_return(@lighthouse_milestone)
    @fresnel_milestone = mock(Fresnel::Milestone)
    Fresnel::Milestone.stub!(:new).and_return(@fresnel_milestone)
  end
  
  it "should find the lighthouse milestone from the id" do
    Lighthouse::Milestone.should_receive(:find).with(12345).and_return(@lighthouse)
    
    Fresnel::Milestone.find(12345)
  end
  
  it "should create a fresnel milestone from the lighthouse milestone" do
    Fresnel::Milestone.should_receive(:new).with(@lighthouse_milestone)
    
    Fresnel::Milestone.find(12345)
  end
  
  it "should return the new milestone if the lighthouse_milestone is found" do
    Fresnel::Milestone.find(12345).should == @fresnel_milestone
  end
  
  it "should return nil if no milestone was found" do
    Lighthouse::Milestone.stub!(:find).and_return(nil)
    
    Fresnel::Milestone.find(12345).should be_nil
  end
end