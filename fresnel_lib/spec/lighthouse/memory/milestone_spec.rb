require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/memory_spec_helper")
require "lighthouse/lighthouse"

describe Lighthouse::Milestone do
  before(:each) do
    Lighthouse::Milestone.destroy_all
    @milestone = create_milestone(:project_id => "project_id", :title => "Milestone One")
  end

  it "should have a project_id information" do
    @milestone.project_id.should == "project_id"
  end
  
  it "should have a title" do
    @milestone.title.should == "Milestone One"
    @milestone.title = "New Title"
    @milestone.title.should == "New Title"
  end

  it "should have goals" do
    @milestone.goals = "New Goal"
    @milestone.goals.should == "New Goal"
  end

  it "should have a due on" do
    @milestone.due_on = "01-05-2007"
    @milestone.due_on.month.should == 5
    @milestone.due_on.day.should == 1
    @milestone.due_on.year.should == 2007
  end
  
  it "should not crash on an invalid date" do
    @milestone.due_on = ""
    @milestone.due_on.should be_nil
  end
  
  it "should have a nil id before saving" do
    milestone = Lighthouse::Milestone.new
    milestone.id.should be_nil
  end

  it "should find one milestone by project id" do
    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.should == [@milestone]
  end
  
  it "should not find a milestone if the project_id does not match" do
    milestone_two = create_milestone(:project_id => "different id", :title => "Milestone Two")

    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.should == [@milestone]
  end

  it "should have an id after save" do
    @milestone.id.should_not be_nil
  end
  
  it "should not duplicate objects on save" do
    @milestone.save
    
    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.size.should == 1
  end
  
  describe "delete" do    
    it "should accept an id and projet_id" do
      Lighthouse::Milestone.delete(@milestone.id, {:project_id => "project_id"})
      
      milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
      milestones.size.should == 0
    end
    
    it "should not delete milestones for a different project" do
      Lighthouse::Milestone.delete(@milestone.id, {:project_id => "different_project_id"})
      
      milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
      milestones.size.should == 1
    end
  end
end
