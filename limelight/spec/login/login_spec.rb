require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "login"



describe Login do
  
  before(:each) do
    @lighthouse_client = mock('lighthouse', :login_to => true)
    @mock_prop = mock('prop', :checked? => false)
    @login, @scene, @production = create_player(Login, 
                                                :scene => {:text_for => '', :load => nil, :set_text_for => nil, :find => @mock_prop}, 
                                                :production => {:lighthouse_client => @lighthouse_client})  
  end

  it "should description" do
    @login.should_not be_nil
    @scene.should_not be_nil
    @production.should_not be_nil
  end
  
  it "should authenticate user information" do
    @scene.should_receive(:text_for).with("username").and_return("Paul Pagel")
    @scene.should_receive(:text_for).with("password").and_return("wouldntyaouliketoknow")
    @scene.should_receive(:text_for).with("account").and_return("checking")
    
    @lighthouse_client.should_receive(:login_to).with("checking", "Paul Pagel", "wouldntyaouliketoknow").and_return(true)
    
    @login.login
  end
  
  it "loads list tickets" do
    @scene.should_receive(:load).with("list_tickets")
    
    @login.login
  end

  it "errors when authentication fails " do
    @lighthouse_client.stub!(:login_to).and_return(false)

    @scene.should_receive(:set_text_for).with('error_message', "Authentication Failed, please try again")
    @scene.should_receive(:set_text_for).with('password', '')

    @login.login
  end

  it "wont error when authentication passes " do
    @lighthouse_client.stub!(:login_to).and_return(true)

    @scene.should_not_receive(:set_text_for).with('error_message', "Authentication Failed, please try again")
    @scene.should_not_receive(:set_text_for).with('password', '')

    @login.login
   end


  it "should display an error if there is no internet" do
    @lighthouse_client.stub!(:login_to).and_raise(SocketError)
    @scene.should_receive(:set_text_for).with('error_message', "You must be connected to the internet to use Fresnel.")
    @scene.should_receive(:set_text_for).with('password', '')
    
    @login.login
  end
  
  it "should not load list tickets if there is no interweb" do
    @lighthouse_client.should_receive(:login_to).and_raise(SocketError)

    @scene.should_not_receive(:load).with("list_tickets")
    
    @login.login
  end
  
  it "should save the user's credentials if the check box is checked and authentication is successful" do
    @scene.should_receive(:text_for).with("username").and_return("Paul Pagel")
    @scene.should_receive(:text_for).with("password").and_return("wouldntyaouliketoknow")
    @scene.should_receive(:text_for).with("account").and_return("checking")

    @mock_prop.stub!(:checked?).and_return(true)
    
    Credential.should_receive(:set).with(:account => "checking", :login => "Paul Pagel", :password => "wouldntyaouliketoknow", :save_credentials => true)
    Credential.should_receive(:save)

    @login.login
  end
  
  it "should set the credentials to nothing if the check box is not checked and authenticated is successful" do
    @mock_prop.stub!(:checked?).and_return(false)

    Credential.should_receive(:set).with()
    
    @login.login
  end
  
end
