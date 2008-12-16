require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'

describe "Props" do
  uses_scene :ticket
  
  it "should have a combo box that points to a type selector player" do
    prop = scene.find("ticket_type")

    prop.name.should == "combo_box"
    prop.players.should == "type_selector"
  end
  
  it "should have a ticket_list" do
    prop = scene.find("ticket_lister")

    prop.name.should == "ticket_lister"
  end
end