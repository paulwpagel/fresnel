require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "credential"

describe Credential do
  before(:each) do
    Encrypter.stub!(:encrypt).and_return("encrypted data")
    @file = mock(File, :write => nil)
    File.stub!(:open).and_yield(@file)
    @credential = Credential.new(:account => "AFlight", :login => "paul", :password => "guessingwontwork", :project_name => "Project")
  end
  
  it "should have account, login, password and project_name" do
    @credential.account.should == "AFlight"
    @credential.login.should == "paul"
    @credential.password.should == "guessingwontwork"
    @credential.project_name.should == "Project"
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
  
  it "should encrypt the project_name on save" do
    Encrypter.should_receive(:encrypt).with("Project")
    
    @credential.save
  end
  
  it "should make a file to save the encrypted data" do
    File.should_receive(:open).with(anything(), "w+")
    
    @credential.save
  end
  
  it "should write the encrypted data" do
    @file.should_receive(:write).with("encrypted data\n").exactly(4).times
    
    @credential.save
  end
end

describe Credential, "load_saved" do
  before(:each) do
    Encrypter.stub!(:decrypt).and_return("account", "login", "password", "project_name")
    @file = StringIO.new("encrypted account\nencrypted login\nencrypted password\nencrypted project_name\n")
    File.stub!(:open).and_yield(@file)
    @credential = Credential.new(:account => "AFlight", :login => "paul", :password => "guessingwontwork", :project_name => "Project")
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
  
  it "should return nil if the file contents are bad" do
    bad_file = StringIO.new("")
    File.stub!(:open).and_yield(bad_file)
    
    Credential.load_saved.should be_nil
  end

  it "should decrypt the contents of the file" do
    Encrypter.should_receive(:decrypt).with("encrypted account")
    Encrypter.should_receive(:decrypt).with("encrypted login")
    Encrypter.should_receive(:decrypt).with("encrypted password")
    Encrypter.should_receive(:decrypt).with("encrypted project_name")
    
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
    Credential.should_receive(:new).with(:account => "account", :login => "login", :password => "password", :project_name => "project_name").and_return(@credential)
    
    Credential.load_saved
  end
  
  it "should return the created credential" do
    Credential.stub!(:new).and_return(@credential)
    
    Credential.load_saved.should == @credential
  end
end

describe Credential, "clear_saved" do
  before(:each) do
    File.stub!(:delete)
  end
  
  it "should check to see if the file exists" do
    File.should_receive(:exist?).and_return(false)

    Credential.clear_saved
  end
  
  it "should delete the saved credentials if they exist" do
    File.stub!(:exist?).and_return(true)
    File.should_receive(:delete).with(anything())
    
    Credential.clear_saved
  end
  
  it "should not delete the saved credentials if they do not exist" do
    File.stub!(:exist?).and_return(false)
    File.should_not_receive(:delete)
    
    Credential.clear_saved
  end
end