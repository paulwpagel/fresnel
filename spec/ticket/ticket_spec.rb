require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "ticket"


describe Ticket do
  uses_scene :ticket

  before(:each) do
    @lighthouse_client = mock(LighthouseClient)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
  end
    
  it "should call client" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
    @lighthouse_client.should_receive(:authenticate)
    @lighthouse_client.should_receive(:add_ticket).with({:title => "some title"}, anything())
  
    scene.add_ticket
  end
  
end

describe Ticket, "View" do
  uses_scene :ticket
  
  it "should have title and description" do
    scene.find("title").should_not be(nil)
    scene.find("description").should_not be(nil)
  end
    
end