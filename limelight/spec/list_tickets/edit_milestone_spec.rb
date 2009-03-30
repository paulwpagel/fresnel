require File.dirname(__FILE__) + '/../spec_helper'
require "edit_milestone"

describe EditMilestone do
  before(:each) do
    mock_stage_manager
    @edit_milestone, @scene, @production = create_player(EditMilestone,
                                                :scene => {:stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    
    @edit_milestone.stub!(:id).and_return("edit_milestone_12345")
    @edit_milestone.stub!(:remove_all)
    @edit_milestone.stub!(:build)
    @milestone = mock("milestone")
    @project.stub!(:milestone_from_id).and_return(@milestone)
  end

  it "should get the milestone from the project using the id" do
    @project.should_receive(:milestone_from_id).with(12345)
    
    @edit_milestone.edit
  end
  
  it "should use the stage name to get the appropriate stage info" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @edit_milestone.edit
  end
  
  it "should display the edit milestone page" do
    @edit_milestone.should_receive(:build).with(:milestone => @milestone)
    
    @edit_milestone.edit
  end
  
  it "should remove all children before displaying the edit form" do
    @edit_milestone.should_receive(:remove_all).ordered
    @edit_milestone.should_receive(:build).ordered
    
    @edit_milestone.edit
  end
end