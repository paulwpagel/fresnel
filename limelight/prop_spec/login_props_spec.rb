require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'
require "login"

describe Login do
  
  before(:each) do
    setup_mocks
    Credential.stub!(:load_saved).and_return(nil)
  end
  
  uses_scene :login
  
  before(:each) do
    scene.stub!(:load)
    scene.find("username").text = "Paul Pagel"
    scene.find("password").text = "wouldntyaouliketoknow"
    scene.find("account").text = "checking"
  end

  it "should have user name and password fields" do
    scene.find("username").should_not be(nil)
    scene.find("password").should_not be(nil)
    scene.find("account").should_not be(nil)
    scene.find("error_message").should_not be(nil)
  end
  
  it "should have an option to save credentials when logging in" do
    save_credentials = scene.find("save_credentials")
    save_credentials.players.should include("check_box")
  end
end