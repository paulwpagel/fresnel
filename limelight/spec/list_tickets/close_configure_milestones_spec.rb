require File.dirname(__FILE__) + '/../spec_helper'
require "close_configure_milestones"

describe CloseConfigureMilestones do
  before(:each) do
    mock_stage_manager
    @close_configure_milestones, @scene, @production = create_player(CloseConfigureMilestones, 
                                                :scene => {}, 
                                                :production => {})

  end
  
  it "should remove the configure milestones modal" do
    @scene.should_receive(:remove).with(@close_configure_milestones.configure_milestones_wrapper)
    
    @close_configure_milestones.close
  end
end