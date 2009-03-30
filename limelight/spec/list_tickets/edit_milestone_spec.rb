require File.dirname(__FILE__) + '/../spec_helper'
require "edit_milestone"

describe EditMilestone do
  before(:each) do
    mock_stage_manager
    @edit_milestone, @scene, @production = create_player(EditMilestone,
                                                :scene => {}, 
                                                :production => {})
    
    @edit_milestone.stub!(:id).and_return("edit_milestone_12345")
    @edit_milestone.stub!(:remove_all)
  end

  it "should display the edit milestone page" do
    @edit_milestone.should_receive(:build).with(:milestone_id => 12345)
    
    @edit_milestone.edit
  end
  
  it "should remove all children before displaying the edit form" do
    @edit_milestone.should_receive(:remove_all).ordered
    @edit_milestone.should_receive(:build).ordered
    
    @edit_milestone.edit
  end
end