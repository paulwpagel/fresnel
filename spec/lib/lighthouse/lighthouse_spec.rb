require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse"


def create_project
  project = Lighthouse::Project.new
  project.save
  return project
end

def create_project_membership(project_id)
  membership = Lighthouse::ProjectMembership.new(:project_id => project_id)
  membership.save
  return membership
end

def create_ticket(project_id)
  ticket = Lighthouse::Ticket.new(:project_id => project_id)
  ticket.save
  return ticket
end

describe Lighthouse, "base methods" do
  it "should have an account= method" do
    Lighthouse.account = "some value"
  end
  
  it "should authenticate" do
    Lighthouse.authenticate("username", "password").should == true
  end
end

describe Lighthouse::Project do
  before(:each) do
    Lighthouse::Project.destroy_all
    @project = Lighthouse::Project.new(:name => "Some Name")
  end
  
  it "should have a name" do
    @project.name.should == "Some Name"
  end
  
  it "should not have an id before being saved" do
    @project.id.should be_nil
  end

  it "should have a unique id after saving" do
    @project.save
    @project.id.should_not be_nil
    project_two = create_project
    
    @project.id.should_not == project_two.id
  end
  
  it "should find all projects" do
    Lighthouse::Project.find(:all).size.should == 0
    @project.save
    
    Lighthouse::Project.find(:all).should == [@project]
  end
  
  it "should have milestones" do
    @project.milestones.should == []
  end
end

describe Lighthouse::User do
  it "should exist" do
    Lighthouse::User.new
  end
end

describe Lighthouse::Ticket do
  before(:each) do
    Lighthouse::Project.destroy_all
    Lighthouse::Ticket.destroy_all
    @project = create_project    
    @ticket = Lighthouse::Ticket.new(:project_id => @project.id)
  end
  
  it "should have a project_id" do
    @ticket.project_id.should == @project.id
  end
  
  it "should not have an id before being saved" do
    @ticket.id.should be_nil
  end
  
  it "should have a state" do
    @ticket.state = "open"
    
    @ticket.state.should == "open"
  end
  
  describe "with one saved ticket" do
    before(:each) do
      @ticket.save
    end
    
    it "should have a unique id after saving" do
      @ticket.id.should_not be_nil
      ticket_two = create_ticket(@project.id)
    
      @ticket.id.should_not == ticket_two.id
    end
    
    it "should have a find method that returns all tickets for a project when searching for all tickets" do
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :query => "all"})
    
      tickets.size.should == 1
      tickets[0].should == @ticket
    end
    
    it "should not return tickets on a different project" do
      project_two = create_project
      ticket_two = create_ticket(project_two.id)
      tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => @project.id, :query => "all"})

      tickets.size.should == 1
      tickets[0].should == @ticket
    end
  
    it "should find a single ticket for one project" do
      found_ticket = Lighthouse::Ticket.find(@ticket.id, :params => {:project_id => @projectid})
    
      found_ticket.should == @ticket
    end
  
    it "should find a different ticket for one project" do
      ticket_two = create_ticket(@project.id)
      found_ticket = Lighthouse::Ticket.find(ticket_two.id, :params => {:project_id => @project.id})
    
      found_ticket.should == ticket_two
    end
    
    it "should find a ticket on a different project" do
      project_two = create_project
      ticket_two = create_ticket(project_two.id)
      found_ticket = Lighthouse::Ticket.find(ticket_two.id, :params => {:project_id => project_two.id})
    
      found_ticket.should == ticket_two
    end
  end
  # Lighthouse::Ticket.find(ticket_id, :params => {:project_id => project_id})
  # Lighthouse::Ticket.find(:all, :params => {:project_id => project_id, :q => "state:open"})
end

describe Lighthouse::Milestone do
  it "should exist" do
    Lighthouse::Milestone.new
  end
end

describe Lighthouse::ProjectMembership do
  before(:each) do
    Lighthouse::Project.destroy_all
    Lighthouse::ProjectMembership.destroy_all
    @project_one = create_project
    @membership = Lighthouse::ProjectMembership.new(:project_id => @project_one.id)
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