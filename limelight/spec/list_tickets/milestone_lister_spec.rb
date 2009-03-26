require File.dirname(__FILE__) + '/../spec_helper'
require "milestone_lister"

module Limelight
  class Prop
  end
end

describe MilestoneLister do
  before(:each) do
    mock_stage_manager
    @project.stub!(:milestone_titles).and_return([])
    @milestone_lister, @scene, @production = create_player(MilestoneLister, 
                                                :scene => {:stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @milestone_lister.stub!(:remove_all)
  end
  
  it "should wrap the show_project_milestones method in an observe method" do
    @milestone_lister.should_receive(:show_project_milestones)
    
    @milestone_lister.observe
  end
  
  it "should get the current project from the stage_manager using the stage name" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @milestone_lister.list_titles
  end
  
  it "should make a prop for one milestone title" do
    prop = mock('prop')
    @project.should_receive(:milestone_titles).and_return(["Milestone One"])
    Limelight::Prop.should_receive(:new).with(:name => "milestone", :text => "Milestone One", :id => "milestone_1").and_return(prop)
    @milestone_lister.should_receive(:add).with(prop)
    
    @milestone_lister.list_titles
  end
  
  it "should make a prop for the second milestone title" do
    prop = mock('prop')
    prop2 = mock('prop2')
    @project.should_receive(:milestone_titles).and_return(["Milestone One", "Milestone Two"])
    Limelight::Prop.should_receive(:new).with(:name => "milestone", :text => "Milestone One", :id => "milestone_1").and_return(prop)
    Limelight::Prop.should_receive(:new).with(:name => "milestone", :text => "Milestone Two", :id => "milestone_2").and_return(prop2)
    @milestone_lister.should_receive(:add).with(prop)
    @milestone_lister.should_receive(:add).with(prop2)
    
    @milestone_lister.list_titles
  end

  it "sets a milestone title to be active" do
    prop = mock('prop')
    @project.should_receive(:milestone_titles).and_return(["Milestone One"])
    active_prop = mock('active prop')
    active_prop.should_receive(:text).and_return("Milestone One")
    @scene.should_receive(:find).with("id").and_return(active_prop)
    Limelight::Prop.should_receive(:new).with(:name => "active_milestone", :text => "Milestone One", :id => "milestone_1").and_return(prop)
    @milestone_lister.should_receive(:add).with(prop)
    @milestone_lister.activate("id")
  end
  
  it "should remove_all before it lists" do
    @milestone_lister.should_receive(:remove_all)
    @milestone_lister.stub!(:list_titles)
    
    @milestone_lister.show_project_milestones
  end
  
  it "should remove_all before it activates a milestone title" do
    milestone = mock("milestone", :text => nil)
    @scene.stub!(:find).and_return(milestone)
    @milestone_lister.should_receive(:remove_all)
    @milestone_lister.stub!(:list_titles)
    
    @milestone_lister.activate("id")
  end
  
end