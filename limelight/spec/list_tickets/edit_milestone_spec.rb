require File.dirname(__FILE__) + '/../spec_helper'
require "edit_milestone"

describe EditMilestone do
  before(:each) do
    mock_stage_manager
    @edit_milestone, @scene, @production = create_player(EditMilestone,
                                                :scene => {:build => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    
  end

  it "should display the edit milestone page" do
    @edit_milestone.stub!(:id).and_return("edit_milestone_12345")
    @scene.should_receive(:build).with(:milestone_id => 12345)
    
    @edit_milestone.edit
  end
end



