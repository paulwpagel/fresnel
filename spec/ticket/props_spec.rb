require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'

describe "Props" do
  # uses_scene :ticket
  
  it "should have a combo box that points to a type selector player" do
    pending do
      prop = scene.find("ticket_type")
    
      prop.name.should == "combo_box"
      prop.players.should == "type_selector"
    end
  end
end