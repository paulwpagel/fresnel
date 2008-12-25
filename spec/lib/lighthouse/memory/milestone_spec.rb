require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe Lighthouse::Memory::Milestone do

  it "should have title" do
    milestone = Lighthouse::Memory::Milestone.new(:title => "The great milestone", :id => 2)
    milestone.title.should == "The great milestone"
  end
end
