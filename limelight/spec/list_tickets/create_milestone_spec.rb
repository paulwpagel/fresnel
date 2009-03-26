require File.dirname(__FILE__) + '/../spec_helper'
require "create_milestone"

describe CreateMilestone do
  before(:each) do
    mock_stage_manager
    @create_milestone, @scene, @production = create_player(CreateMilestone,
                                                :scene => {:stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @create_milestone.milestone_lister.stub!(:show_project_milestones)
  end
  
  it "should use the stage name to get the current project" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @create_milestone.create
  end
  
  it "should create the milestone on the project with the given title" do
    @create_milestone.new_milestone_title.stub!(:text).and_return("Some Title")
    @project.should_receive(:create_milestone).with(hash_including(:title => "Some Title"))
    
    @create_milestone.create
  end
  
  it "should create the milestone on the project with the given goals" do
    @create_milestone.new_milestone_goals.stub!(:text).and_return("Some Goal")
    @project.should_receive(:create_milestone).with(hash_including(:goals => "Some Goal"))
    
    @create_milestone.create
  end
  
  it "should create the milestone on the project with the given due date" do
    @create_milestone.new_milestone_due_on.stub!(:text).and_return("04-30-1986")
    @project.should_receive(:create_milestone).with(hash_including(:due_on => "04-30-1986"))
    
    @create_milestone.create
  end
  
  it "should update the list of milestones after creating the new milestone" do
    @project.should_receive(:create_milestone).ordered
    @create_milestone.milestone_lister.should_receive(:show_project_milestones).ordered
    
    @create_milestone.create
  end
  
end