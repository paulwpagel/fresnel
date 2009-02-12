require File.dirname(__FILE__) + '/../spec_helper'
require "encrypter"

describe Encrypter do
  it "should convert the string to hex encoded ascii" do
    Encrypter.encrypt("string").should == "737472696e67"
  end
  
  it "should convert from ascii back to a string on decrypt" do
    Encrypter.decrypt("737472696e67").should == "string"
  end
  
  it "should treat nil as an empty string" do
    Encrypter.encrypt(nil).should == Encrypter.encrypt("")
  end
end