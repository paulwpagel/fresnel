require File.dirname(__FILE__) + '/../spec_helper'
require "existing_milestones"

describe ExistingMilestones do
  before(:each) do
    mock_stage_manager
    @existing_milestones, @scene, @production = create_player(ExistingMilestones, 
                                                :scene => {:stage => @stage, :find => nil}, 
                                                :production => {:stage_manager => @stage_manager})
    @existing_milestones.stub!(:build)
    @existing_milestones.stub!(:remove_all)
  end
  
  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)

    @existing_milestones.refresh
  end
  
  it "should refresh the list of milestones" do
    milestones = [mock("milestone")]
    @project.stub!(:milestones).and_return(milestones)
    @existing_milestones.should_receive(:build).with(:milestones => milestones)
    
    @existing_milestones.refresh
  end
  
  it "should remove all children before building" do
    @existing_milestones.should_receive(:remove_all).ordered
    @existing_milestones.should_receive(:build).ordered
    
    @existing_milestones.refresh
  end
end