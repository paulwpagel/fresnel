require File.dirname(__FILE__) + '/../spec_helper'
require "encrypter"

describe Encrypter do
  it "should have an encrypt method that takes a string to encrypt" do
    Encrypter.encrypt("some string")
  end
end