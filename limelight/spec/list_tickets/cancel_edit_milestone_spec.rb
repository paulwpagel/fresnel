require File.dirname(__FILE__) + '/../spec_helper'
require "cancel_edit_milestone"

describe CancelEditMilestone do
  before(:each) do
    mock_stage_manager
    @cancel_edit_milestone, @scene, @production = create_player(CancelEditMilestone, 
                                                :scene => {}, 
                                                :production => {})
  end
  
  it "should refresh the existing milestone list" do
    @cancel_edit_milestone.existing_milestones.should_receive(:refresh)
    
    @cancel_edit_milestone.cancel
  end
end