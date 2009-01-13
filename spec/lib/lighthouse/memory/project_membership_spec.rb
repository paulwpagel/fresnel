require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/memory_spec_helper")
require "lighthouse/memory/project_membership"
require "lighthouse/lighthouse"

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