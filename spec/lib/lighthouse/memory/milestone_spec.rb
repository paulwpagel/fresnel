require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/memory_spec_helper")
require "lighthouse/lighthouse"

describe Lighthouse::Milestone do
  before(:each) do
    Lighthouse::Milestone.destroy_all
    @milestone = create_milestone(:project_id => "project_id", :title => "Milestone One")
  end

  it "should have basic information" do
    @milestone.project_id.should == "project_id"
    @milestone.title.should == "Milestone One"
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
end
