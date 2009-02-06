require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "no_internet_retry"

describe NoInternetRetry do
  
  uses_scene :no_internet

  it "should retry successfully" do
    Credential.should_receive(:load_saved)
    scene.should_receive(:load).with("list_tickets")

    scene.find("no_internet_retry_button").button_pressed(nil)
  end
  
  it "should not do anything if it can not retry" do
    Credential.should_receive(:load_saved).and_raise(SocketError)
    scene.should_not_receive(:load).with("list_tickets")

    scene.find("no_internet_retry_button").button_pressed(nil)    
  end
end