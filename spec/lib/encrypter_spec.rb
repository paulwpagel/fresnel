require File.dirname(__FILE__) + '/../spec_helper'
require "encrypter"

describe Encrypter, "encrypt" do
  before(:each) do
    @encrypter = mock("encrypter", :encrypt => nil, :key= => nil, :update => nil, :final => nil)
    OpenSSL::Cipher::Cipher.stub!(:new).and_return(@encrypter)
    @key = Digest::SHA1.hexdigest("fresnel")
  end
    
  it "should create a cipher to encrypt the data" do
    OpenSSL::Cipher::Cipher.should_receive(:new).with("aes-256-cbc").and_return(@encrypter)

    Encrypter.encrypt("some string")
  end
  
  it "should use the cipher to encrypt the string" do
    @encrypter.should_receive(:encrypt).ordered
    @encrypter.should_receive(:key=).with(@key).ordered
    @encrypter.should_receive(:update).with("some string").ordered
    @encrypter.should_receive(:final).ordered
    
    Encrypter.encrypt("some string")
  end
  
  it "should return the result of final" do
    @encrypter.stub!(:final).and_return("encrypted data")
    
    Encrypter.encrypt("some string").should == "encrypted data"
  end
end

describe Encrypter, "decrypt" do
  it "should have a decrypt method that takes an encrypted string" do
    Encrypter.decrypt("encrypted data")
  end
end

describe Encrypter, "key" do
  it "should have a key" do
    Encrypter.key.should == Digest::SHA1.hexdigest("fresnel")
  end
end