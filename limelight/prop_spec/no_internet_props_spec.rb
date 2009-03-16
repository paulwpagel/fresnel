require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'

describe "NoInternet props" do
  
  uses_scene :no_internet

  it "should have an error message" do
    prop = scene.find("no_internet_message")
    
    prop.should_not be_nil
    prop.text.should == "You must be connected to the internet to use fresnel"
  end
  
  it "should have retry button" do
    prop = scene.find("no_internet_retry_button")
    
    prop.should_not be_nil
    prop.text.should == "Retry"
    prop.players.should include("no_internet_retry")    
  end
end
