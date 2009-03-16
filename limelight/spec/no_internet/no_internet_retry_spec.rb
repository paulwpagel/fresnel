require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "no_internet_retry"

describe NoInternetRetry do
  
  before(:each) do
    @no_internet_retry, @scene, @production = create_player(NoInternetRetry, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {})

  end
  
  it "should retry successfully" do
    Credential.should_receive(:load_saved)
    @scene.should_receive(:load).with("list_tickets")
    @no_internet_retry.no_internet
  end
  
  it "should not do anything if it can not retry" do
    Credential.should_receive(:load_saved).and_raise(SocketError)
    @scene.should_not_receive(:load).with("list_tickets")

    @no_internet_retry.no_internet
  end
end