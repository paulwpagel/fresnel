require File.dirname(__FILE__) + '/../spec_helper'
require "configure_milestones"

describe ConfigureMilestones do
  before(:each) do
    mock_stage_manager
    @configure_milestones, @scene, @production = create_player(ConfigureMilestones,
                                                :scene => {:build => nil}, 
                                                :production => {})
  end
  
  it "should display the milestone configuration page" do
    @scene.should_receive(:build)
    
    @configure_milestones.open_milestones
  end
end