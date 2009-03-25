require File.dirname(__FILE__) + '/../spec_helper'
require "configure_milestones"

describe ConfigureMilestones do
  before(:each) do
    @configure_milestones, @scene, @production = create_player(ConfigureMilestones,
                                                :scene => {:load => nil}, 
                                                :production => {})
  end
  
  it "should open the milestones scene" do
    @scene.should_receive(:load).with("milestones")
    
    @configure_milestones.open_milestones
  end
end