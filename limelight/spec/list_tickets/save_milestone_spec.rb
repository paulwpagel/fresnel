require File.dirname(__FILE__) + '/../spec_helper'
require "save_milestone"

describe SaveMilestone do
  before(:each) do
    mock_stage_manager
    @save_milestone, @scene, @production = create_player(SaveMilestone, 
                                                :scene => {:stage => @stage, :find => nil}, 
                                                :production => {:stage_manager => @stage_manager})
    @save_milestone.stub!(:id).and_return("save_milestone_12345")
    @save_milestone.existing_milestones.stub!(:refresh)
  end
    
  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)

    @save_milestone.save
  end
  
  it "should update the milestone's title" do
    title_prop = mock("prop", :text => "New Title")
    @scene.should_receive(:find).with("milestone_title_12345").and_return(title_prop)
    @project.should_receive(:update_milestone).with(12345, hash_including(:title => "New Title"))
    
    @save_milestone.save
  end
  
  it "should update the milestone's goals" do
    goals_prop = mock("prop", :text => "New Goals")
    @scene.should_receive(:find).with("milestone_goals_12345").and_return(goals_prop)
    @project.should_receive(:update_milestone).with(12345, hash_including(:goals => "New Goals"))
    
    @save_milestone.save
  end
  
  it "should update the milestone's due one" do
    date_prop = mock("prop", :text => "New Date")
    @scene.should_receive(:find).with("milestone_due_on_12345").and_return(date_prop)
    @project.should_receive(:update_milestone).with(12345, hash_including(:due_on => "New Date"))
    
    @save_milestone.save
  end
  
  it "should refresh the list of milestones" do
    @save_milestone.existing_milestones.should_receive(:refresh)
    
    @save_milestone.save
  end
  
  it "should define the mouse clicked event" do
    lambda{@save_milestone.mouse_clicked(nil)}.should_not raise_error
  end
  
end