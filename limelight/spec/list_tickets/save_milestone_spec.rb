require File.dirname(__FILE__) + '/../spec_helper'
require "save_milestone"

describe SaveMilestone do
  before(:each) do
    mock_stage_manager
    @save_milestone, @scene, @production = create_player(SaveMilestone, 
                                                :scene => {:stage => @stage, :find => nil}, 
                                                :production => {:stage_manager => @stage_manager})
    @save_milestone.stub!(:id).and_return("save_milestone_12345")
  end
    
  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)

    @save_milestone.save
  end
  
  it "should update the milestone's title" do
    title_prop = mock("prop", :text => "New Title")
    @scene.should_receive(:find).with("milestone_title_12345").and_return(title_prop)
    @project.should_receive(:update_milestone).with(12345, hash_including(:title => "New Title"))
    
    @save_milestone.save
  end
end