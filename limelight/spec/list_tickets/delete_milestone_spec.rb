require File.dirname(__FILE__) + '/../spec_helper'
require "delete_milestone"

describe DeleteMilestone do
  before(:each) do
    mock_stage_manager
    @delete_milestone, @scene, @production = create_player(DeleteMilestone,
                                                :scene => {:stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @delete_milestone.stub!(:id).and_return("delete_milestone_12345")
    @delete_milestone.existing_milestones.stub!(:refresh)
  end
  
  it "should use the stage name to get the current project" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @delete_milestone.delete
  end
  
  it "should delete the milestone from the project passing in the id" do
    @project.should_receive(:delete_milestone).with(12345)
    
    @delete_milestone.delete
  end
  
  it "should refresh the list of milestones" do
    @delete_milestone.existing_milestones.should_receive(:refresh)
    
    @delete_milestone.delete
  end
end