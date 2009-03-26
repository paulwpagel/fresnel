require File.dirname(__FILE__) + '/../spec_helper'
require "configure_milestones"

describe ConfigureMilestones do
  before(:each) do
    mock_stage_manager
    @configure_milestones, @scene, @production = create_player(ConfigureMilestones,
                                                :scene => {:build => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @milestones = [mock("milestone")]
    @project.stub!(:milestones).and_return(@milestones)
  end
  
  it "should use the stage name to get the stage_info" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @configure_milestones.open_milestones
  end
  
  it "should display the milestone configuration page" do
    @scene.should_receive(:build).with(:milestones => @milestones)
    
    @configure_milestones.open_milestones
  end
end