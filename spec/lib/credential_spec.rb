require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "credential"

describe Credential do
  before(:each) do
    Encrypter.stub!(:encrypt).and_return("encrypted data")
    @file = mock(File, :write => nil)
    File.stub!(:open).and_yield(@file)
    @credential = Credential.new(:account => "AFlight", :login => "paul", :password => "guessingwontwork")
  end
  
  it "should have account, login, and password" do
    @credential.account.should == "AFlight"
    @credential.login.should == "paul"
    @credential.password.should == "guessingwontwork"
  end
  
  it "should respond to save" do
    lambda{@credential.save}.should_not raise_error
  end
  
  it "should encrypt the password on save" do
    Encrypter.should_receive(:encrypt).with("guessingwontwork")
    
    @credential.save
  end
  
  it "should encrypt the username on save" do
    Encrypter.should_receive(:encrypt).with("paul")
    
    @credential.save
  end
  
  it "should encrypt the account on save" do
    Encrypter.should_receive(:encrypt).with("AFlight")
    
    @credential.save
  end
  
  it "should make a file to save the encrypted data" do
    File.should_receive(:open).with(anything(), "w+")
    
    @credential.save
  end
  
  it "should write the encrypted data" do
    @file.should_receive(:write).with("encrypted data\n").exactly(3).times
    
    @credential.save
  end
end

describe Credential, "load_saved" do
  before(:each) do
    Encrypter.stub!(:decrypt).and_return("account", "login", "password")
    @file = StringIO.new("encrypted account\nencrypted login\nencrypted password\n")
    File.stub!(:open).and_yield(@file)
    @credential = Credential.new(:account => "AFlight", :login => "paul", :password => "guessingwontwork")
    Lighthouse::LighthouseApi.stub!(:login_to).and_return(true)
    File.stub!(:exist?).and_return(true)
  end
  
  it "should open the file containing the save credentials" do
    File.should_receive(:open).with(anything(), "r")
    
    Credential.load_saved
  end
  
  it "should return nil if the file does not exist" do
    File.should_receive(:exist?).and_return(false)
    
    Credential.load_saved.should be_nil
  end

  it "should decrypt the contents of the file" do
    Encrypter.should_receive(:decrypt).with("encrypted account")
    Encrypter.should_receive(:decrypt).with("encrypted login")
    Encrypter.should_receive(:decrypt).with("encrypted password")
    
    Credential.load_saved
  end

  it "should login using the contents of the file" do
    Lighthouse::LighthouseApi.should_receive(:login_to).with("account", "login", "password")
    
    Credential.load_saved
  end
  
  it "should return nil if the login was unsuccessful" do
    Lighthouse::LighthouseApi.stub!(:login_to).and_return(false)
    
    Credential.load_saved.should be_nil
  end
  
  it "should create a valid credential if the login was successful" do
    Lighthouse::LighthouseApi.stub!(:login_to).and_return(false)
    Credential.should_receive(:new).with(:account => "account", :login => "login", :password => "password").and_return(@credential)
    
    Credential.load_saved
  end
  
  it "should return the created credential" do
    Credential.stub!(:new).and_return(@credential)
    
    Credential.load_saved.should == @credential
  end
end