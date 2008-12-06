require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require "main"
require 'limelight/specs/spec_helper'

class LighthouseClient
end

describe Main do
  uses_scene :main

  it "should accept title and description" do
    lighthouse_client = mock(LighthouseClient)
    scene.add Limelight::Prop.new(:id => "title", :text => "some title")
    scene.add Limelight::Prop.new(:id => "description", :text => "some description")
  
    LighthouseClient.should_receive(:new).and_return(lighthouse_client)
    lighthouse_client.should_receive(:add_ticket).with("some title", "some description")
  
    scene.add_ticket
  end
  
  it "should not create a ticket if it can't find the title or description" do
    lighthouse_client = mock(LighthouseClient)
  
    LighthouseClient.stub!(:new).and_return(lighthouse_client)
    lighthouse_client.should_not_receive(:add_ticket)
  
    scene.add_ticket    
  end
end