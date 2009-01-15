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
  before(:each) do
    @decrypter = mock("decrypter", :decrypt => nil, :key= => nil, :update => nil, :final => nil)
    OpenSSL::Cipher::Cipher.stub!(:new).and_return(@decrypter)
    @key = Digest::SHA1.hexdigest("fresnel")
  end
  
  it "should have a decrypt method that takes an encrypted string" do
    Encrypter.decrypt("encrypted data")
  end
  
  it "should create a cipher to decrypt the data" do
    OpenSSL::Cipher::Cipher.should_receive(:new).with("aes-256-cbc").and_return(@decrypter)
    
    Encrypter.decrypt("encrypted data")
  end
  
  it "should use the cipher to decrypt the encrypted data" do
    @decrypter.should_receive(:decrypt).ordered
    @decrypter.should_receive(:key=).with(@key).ordered
    @decrypter.should_receive(:update).with("encrypted data").ordered
    @decrypter.should_receive(:final).ordered
    
    Encrypter.decrypt("encrypted data")
  end
  
  it "should return the result of final" do
    @decrypter.stub!(:final).and_return("decrypted data")
    
    Encrypter.decrypt("encrypted data").should == "decrypted data"
  end
end

describe Encrypter, "key" do
  it "should have a key" do
    Encrypter.key.should == Digest::SHA1.hexdigest("fresnel")
  end
end