require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "login"

describe Login do
  
  before(:each) do
    mock_lighthouse
  end
  
  uses_scene :login
  
  before(:each) do
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
  
  it "should take the name, password, and account name and send it to be authenticated" do
    @lighthouse_client.should_receive(:login_to).with("checking", "Paul Pagel", "wouldntyaouliketoknow").and_return(true)
    
    scene.should_receive(:load).with("ticket")
    
    scene.load_inputs
    scene.log_in
    
    scene.production.credential.should_not be(nil)
    scene.production.credential.account.should == "checking"
    scene.production.credential.login.should == "Paul Pagel"
    scene.production.credential.password.should == "wouldntyaouliketoknow"
    scene.production.credential.logged_in?.should be(true)
  end
  
  it "should error when authentication fails" do
    @lighthouse_client.should_receive(:login_to).with(anything(), anything(), anything()).and_return(false)
    
    scene.should_not_receive(:load).with("ticket")
    
    scene.load_inputs
    scene.log_in
    
    scene.find("error_message").text.should == "Authentication Failed, please try again"
    scene.find("password").text.should == ""
  end  
  
  it "should error if there is no username" do
    scene.find("username").text = ""
    
    @lighthouse_client.should_receive(:login_to).with(anything(), anything(), anything()).and_raise(URI::InvalidURIError.new(""))

    scene.load_inputs
    scene.log_in
    
    scene.find("error_message").text.should == "Authentication Failed, please try again"
  end
  
end
