require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'

describe "Milestones Props" do
  before(:each) do
    setup_mocks
    @date = Date.today
    milestone_one = mock("milestone", :title => "Milestone 123", :id => 123, :goals => "Some Goals", :due_on => @date)
    @milestone_two = mock("milestone", :title => "Milestone 456", :id => 456, :goals => nil, :due_on => nil)
    @project.stub!(:milestones).and_return([milestone_one, @milestone_two])
    @project.stub!(:milestone_from_id).and_return(milestone_one)
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    scene.find("configure_milestones").mouse_clicked(nil)
    scene.find("edit_milestone_123").mouse_clicked(nil)
  end
  
  it "should have an input field for the title" do
    prop = scene.find("milestone_title_123")
    prop.name.should == "text_box"
    prop.text.should == "Milestone 123"
  end

  it "should have an input field for the goals" do
    prop = scene.find("milestone_goals_123")
    prop.name.should == "text_box"
    prop.text.should == "Some Goals"
  end

  it "should have an input field for the due on date" do
    prop = scene.find("milestone_due_on_123")
    prop.name.should == "text_box"
    prop.text.should == "#{@date.month}-#{@date.day}-#{@date.year}"
  end
  
  it "should have a save_button" do
    prop = scene.find("save_milestone_123")
    prop.name.should == "button"
    prop.players.should == "save_milestone"
  end
  
  it "should leave the due on input empty if the date is nil" do
    @project.stub!(:milestone_from_id).and_return(@milestone_two)
    scene.find("edit_milestone_456").mouse_clicked(nil)
    
    prop = scene.find("milestone_due_on_456")
    prop.name.should == "text_box"
    prop.text.should == ""
  end
end