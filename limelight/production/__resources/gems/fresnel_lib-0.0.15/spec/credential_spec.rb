require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require "credential"

describe Credential do
  before(:each) do
    Encrypter.stub!(:encrypt).and_return("encrypted data")
    @credential = Credential.new("AFlight", "paul", "guessingwontwork", "Project", true)
  end
  
  it "should know if should be remembered" do
    @credential.remember_me?.should be_true
  end

  it "should know if should not be remembered" do
    credential = Credential.new("", "", "", "", false)
    credential.remember_me?.should be_false
  end
  
  it "should have account, login, password and project_name" do    # 
    @credential.account.should == "AFlight"
    @credential.login.should == "paul"
    @credential.password.should == "guessingwontwork"
    @credential.project_name.should == "Project"
  end

  it "should encrypt the account on save" do
    Encrypter.should_receive(:encrypt).with("AFlight").and_return("encrypted account")
    
    @credential.encrypted.should include("encrypted account")
  end
  
  it "should encrypt the username on save" do
    Encrypter.should_receive(:encrypt).with("paul").and_return("encrypted username")
    
    @credential.encrypted.should include("encrypted username")
  end
  
  it "should encrypt the password" do
    Encrypter.should_receive(:encrypt).with("guessingwontwork").and_return("encrypted password")
    
    @credential.encrypted.should include("encrypted password")
  end  
  
  it "should encrypt the project_name on save" do
    Encrypter.should_receive(:encrypt).with("Project").and_return("encrypted project_name")
    
    @credential.encrypted.should include("encrypted project_name")
  end
  
end

describe Credential, "load_saved" do
  before(:each) do
    @encrypted_data = "encrypted account\nencrypted login\nencrypted password\nencrypted project_name"
    Encrypter.stub!(:decrypt).and_return("account", "login", "password", "project_name")
  end
  
  it "should decrypt the contents of the file" do
    Encrypter.should_receive(:decrypt).with("encrypted account").ordered
    Encrypter.should_receive(:decrypt).with("encrypted login").ordered
    Encrypter.should_receive(:decrypt).with("encrypted password").ordered
    Encrypter.should_receive(:decrypt).with("encrypted project_name").ordered
    
    Credential.decrypt(@encrypted_data)
  end

  it "should create a new credential from the decryptd data" do
    credential = mock("credential")
    Credential.should_receive(:new).with("account", "login", "password", "project_name", true).and_return(credential)
    
    Credential.decrypt(@encrypted_data).should == credential
  end
  
  it "should return nil if the data is bad" do
    Credential.decrypt("").should be_nil
  end
end