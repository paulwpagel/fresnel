require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "title_bar"

describe TitleBar do
  uses_scene :ticket
  
  before(:each) do
    @event = mock('event')
  end
  
  it "should load scene from the id" do
    scene.should_receive(:load).with("add_ticket")
    
    scene.find('add_ticket').button_pressed(@event)
  end
end
