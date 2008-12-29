require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "save_ticket"

describe SaveTicket, "on_click" do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(SaveTicket)
  end
  
  it "should have a button_pressed action" do
    @player_under_test.button_pressed(nil)
  end
end
