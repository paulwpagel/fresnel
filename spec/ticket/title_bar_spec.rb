require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")


describe "title_bar" do
  uses_scene :ticket
  
  before(:each) do
    @event = nil
  end
  
  it "should redirect to the add ticket scene" do
    scene.should_receive(:load).with("add_ticket")

    scene.find("add_ticket").button_pressed(@event)
  end
end
