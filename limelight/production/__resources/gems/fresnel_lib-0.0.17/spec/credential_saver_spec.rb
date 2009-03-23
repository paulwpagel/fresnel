require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require "credential_saver"

def encrypted_account(number = 0)
  return "encrypted account#{number}\nencrypted login\nencrypted password\nencrypted project_name"
end

describe CredentialSaver, "save" do
  before(:each) do
    @file = mock(File, :write => nil)
    File.stub!(:open).and_yield(@file)
    File.stub!(:exist?).and_return(false)
    @credential = mock('credential', :encrypted => "encrypted data", :remember_me? => true)
  end

  it "should open a file to save the credentials in" do
    File.should_receive(:open).with(anything(), "w+").and_yield(@file)
    
    CredentialSaver.save([@credential])
  end
  
  it "should save one encrypted credential" do
    @credential.should_receive(:encrypted).and_return("encrypted data")
    @file.should_receive(:write).with("encrypted data")
    
    CredentialSaver.save([@credential])
  end
  
  it "should save two credentials" do
    @file.should_receive(:write).exactly(2).times
    
    CredentialSaver.save([@credential, @credential])
  end
  
  it "should delete the old file before writing the new one" do
    File.stub!(:exist?).and_return(true)
    File.should_receive(:delete).with(anything()).ordered
    File.should_receive(:open).ordered

    CredentialSaver.save([@credential])
  end
  
  describe "with a non-remembered credential" do
    it "should not write the credential" do
      credential = mock("credential", :remember_me? => false, :encrypted => "non-remembered credential")
      credential.should_receive(:remember_me?).and_return(false)
      @file.should_not_receive(:write).with("non-remembered credentials")
      
      CredentialSaver.save([credential])
    end
  end  
end

describe CredentialSaver, "loading saved credentials" do
  before(:each) do
    @credential = mock("account")
    @file = StringIO.new(encrypted_account)
    File.stub!(:open).and_yield(@file)
    File.stub!(:exist?).and_return(true)
    Credential.stub!(:decrypt).and_return(@credential)
  end
      
  it "should load one saved credential" do
    @file = StringIO.new(encrypted_account)
    File.should_receive(:open).with(anything(), "r").and_yield(@file)
    
    Credential.should_receive(:decrypt).with(encrypted_account).and_return(@credential)
    CredentialSaver.load_saved
  end
  
  it "should add the account to the list of credentials" do
    credentials = CredentialSaver.load_saved
    
    credentials.size.should == 1
    credentials[0].should == @credential
  end
  
  it "should load two saved credentials" do
    @file = StringIO.new("#{encrypted_account(0)}\n#{encrypted_account(1)}")
    File.should_receive(:open).with(anything(), "r").and_yield(@file)
    
    Credential.should_receive(:decrypt).with(encrypted_account(0)).and_return(@credential)
    Credential.should_receive(:decrypt).with(encrypted_account(1)).and_return(@credential)
    CredentialSaver.load_saved
  end
  
  it "should have 0 credentials if the file does not exist" do
    File.should_receive(:exist?).and_return(false)
    File.should_not_receive(:open)
    
    credentials = CredentialSaver.load_saved
    credentials.should be_empty
  end
  
  it "should not include credentials that could not be loaded" do
    @file = StringIO.new("#{encrypted_account(0)}\n#{encrypted_account(1)}")
    File.should_receive(:open).with(anything(), "r").and_yield(@file)
    Credential.should_receive(:decrypt).with(encrypted_account(0)).and_return(@credential)
    Credential.should_receive(:decrypt).with(encrypted_account(1)).and_return(nil)

    credentials = CredentialSaver.load_saved
    credentials.size.should == 1
  end
  
end

describe CredentialSaver, "load account names" do
  before(:each) do
    @credential_one = mock("credential", :account => "account one")
    @credential_two = mock("credential", :account => "account two")
    @file = StringIO.new("#{encrypted_account(0)}\n#{encrypted_account(1)}")
    File.stub!(:open).and_yield(@file)
    File.stub!(:exist?).and_return(true)
    Credential.stub!(:decrypt).and_return(@credential_one, @credential_two)
  end
  
  it "should return the account names" do
    CredentialSaver.load_account_names.should == ["account one", "account two"]
  end
  
  it "should not return duplicate accounts" do
    @credential_two.stub!(:account).and_return("account one")
    
    CredentialSaver.load_account_names.should == ["account one"]
  end
  
  it "should not fail on nil credentials" do
    Credential.stub!(:decrypt).and_return(@credential_one, nil)
    
    CredentialSaver.load_account_names.should == ["account one"]
  end
end