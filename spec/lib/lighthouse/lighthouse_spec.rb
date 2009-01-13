require File.dirname(__FILE__) + '/../../spec_helper'
require File.expand_path(File.dirname(__FILE__) + "/memory/memory_spec_helper")
require "lighthouse/lighthouse"

describe Lighthouse, "base methods" do
  it "should have an account= method" do
    Lighthouse.account = "some value"
  end
  
  it "should authenticate" do
    Lighthouse.authenticate("username", "password").should == true
  end
end

describe Lighthouse::Milestone do
  before(:each) do
    Lighthouse::Milestone.destroy_all
    @milestone = create_milestone(:project_id => "project_id", :title => "Milestone One")
  end

  it "should have basic information" do
    @milestone.project_id.should == "project_id"
    @milestone.title.should == "Milestone One"
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

  it "should not duplicate objects on save" do
    @milestone.save
    
    milestones = Lighthouse::Milestone.find(:all, :params => {:project_id => "project_id"})
    milestones.size.should == 1
  end
end

describe Lighthouse::ProjectMembership do
  before(:each) do
    Lighthouse::Project.destroy_all
    Lighthouse::ProjectMembership.destroy_all
    @project_one = create_project
    @membership = Lighthouse::ProjectMembership.new(:project_id => @project_one.id)
  end
  
  it "should no users for a project" do
    Lighthouse::ProjectMembership.all_users_for_project("some id").should == []
  end
  
  it "should have a project_id" do
    @membership.project_id.should == @project_one.id
  end
  
  it "should have a save method" do
    @membership.save
  end
  
  it "should find an empty list of memberships for a given project" do
    find_all(@project_one.id).should == []
  end
  
  it "should find one membership for one project" do
    membership = create_project_membership(@project_one.id)

    find_all(@project_one.id).should == [membership]
  end
  
  it "should find one membership for a multiple projects" do
    membership_one = create_project_membership(@project_one.id)
    project_two = create_project
    membership_two = create_project_membership(project_two.id)
  
    find_all(@project_one.id).should == [membership_one]
    find_all(project_two.id).should == [membership_two]
  end
  
  def find_all(project_id)
    return Lighthouse::ProjectMembership.find(:all, :params => {:project_id => project_id})
  end
  
end