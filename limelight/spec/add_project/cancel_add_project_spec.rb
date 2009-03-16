require File.dirname(__FILE__) + '/../spec_helper'
require "cancel_add_project"

describe CancelAddProject do
  
  before(:each) do
    @cancel_add_project, @scene = create_player(CancelAddProject, :scene => {:load => nil})  
  end

  it "should show list tickets scene" do
    @scene.should_receive(:load).with("list_tickets")

    @cancel_add_project.cancel
  end

end