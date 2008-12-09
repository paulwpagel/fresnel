require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "ticket"

$testing = true

describe Ticket do
  uses_scene :ticket

  before(:each) do
    @milestones = [mock("milestone", :title => "milestone 1")]
    @lighthouse_client = mock(LighthouseClient, :authenticate => nil, :add_ticket => nil, :milestones => @milestones)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
  end
    
  it "should call client" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
    
    @lighthouse_client.should_receive(:authenticate)
    @lighthouse_client.should_receive(:add_ticket).with({:title => "some title"}, anything())
  
    scene.add_ticket
  end
  
  it "should clear out the text boxes when a ticket is added" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
  
    scene.add_ticket
    
    scene.find("title").text.should == ""
    scene.find("description").text.should == ""
  end
  
  it "should give a choice for milestones" do
    @lighthouse_client.should_receive(:milestones).with(anything()).and_return(@milestones)
    
    scene.load_milestones
    
    milestone_input = scene.find("milestones")
    milestone_input.choices.should == ["milestone 1"]
  end

end

describe Ticket, "Props" do
  uses_scene :ticket
  
  it "should have title and description" do
    scene.find("title").should_not be(nil)
    scene.find("description").should_not be(nil)
    scene.find("milestones").should_not be(nil)
  end

end

describe Ticket, "Limelight event mappings" do
  uses_scene :ticket
  
  before(:each) do
    @event = nil
  end
  
  it "should call add_ticket on " do
    scene.should_receive(:add_ticket)
    
    scene.button_pressed(@event)
  end
  
end
