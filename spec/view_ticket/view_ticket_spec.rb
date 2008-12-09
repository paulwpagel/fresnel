require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "view_ticket"

$testing = true

describe ViewTicket do
  uses_scene :view_ticket
  
  before(:each) do
    scene.production.current_ticket = mock("ticket", :title => 'title')
    @mop = mock("prop")
    Limelight::Prop.stub!(:new).and_return(@mop)
    scene.children[0].stub!(:add)
  end
  
  it "should make a prop for the current ticket's title" do
    Limelight::Prop.should_receive(:new).with(hash_including(:text => "title"))
    
    scene.load_current_ticket
  end
  
  it "should add the current_ticket prop to the scene" do    
    scene.children[0].should_receive(:add).with(@mop)
    
    scene.load_current_ticket
  end
  
end