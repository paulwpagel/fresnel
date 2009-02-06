require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "login"

describe Login do
  
  before(:each) do
    mock_lighthouse
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
  
  it "should take the name, password, and account name and send it to be authenticated" do
    @lighthouse_client.should_receive(:login_to).with("checking", "Paul Pagel", "wouldntyaouliketoknow").and_return(true)
    
    scene.should_receive(:load).with("list_tickets")
    
    scene.load_inputs
    scene.log_in
  end
  
  it "should create an object to save the user's credentials if the check box is checked and authentication is successful" do
    @lighthouse_client.stub!(:login_to).and_return(true)
    scene.find("save_credentials").checked = true
    credential = mock(Credential)
    Credential.stub!(:new).and_return(credential)
    credential.should_receive(:save)
    
    scene.load_inputs
    scene.log_in
  end
  
  it "should not save the credentials if the check box is not checked" do
    @lighthouse_client.stub!(:login_to).and_return(true)
    credential = mock(Credential)
    Credential.stub!(:new).and_return(credential)
    credential.should_not_receive(:save)
    
    scene.load_inputs
    scene.log_in
  end
  
  it "should error when authentication fails" do
    @lighthouse_client.should_receive(:login_to).with(anything(), anything(), anything()).and_return(false)
    
    scene.should_not_receive(:load).with("list_tickets")
    
    scene.load_inputs
    scene.log_in
    
    scene.find("error_message").text.should == "Authentication Failed, please try again"
    scene.find("password").text.should == ""
  end  
  
  it "should display an error if there is no internet" do
    @lighthouse_client.should_receive(:login_to).and_raise(SocketError)
    
    scene.find("login_button").button_pressed(nil)
    
    scene.find("error_message").text.should == "You must be connected to the internet to use Fresnel."
  end
  
  it "should not load list_tickets if there is no internet" do
    @lighthouse_client.should_receive(:login_to).and_raise(SocketError)

    scene.should_not_receive(:load).with("list_tickets")
    
    scene.find("login_button").button_pressed(nil)
  end
    
end
