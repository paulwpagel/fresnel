require File.dirname(__FILE__) + '/../../spec_helper'
require File.expand_path(File.dirname(__FILE__) + "/memory_spec_helper")
require "lighthouse/lighthouse"

describe Lighthouse, "base methods" do
  it "should have an account= method" do
    Lighthouse.account = "some value"
  end
  
  it "should authenticate" do
    Lighthouse.authenticate("username", "password").should == true
  end
end