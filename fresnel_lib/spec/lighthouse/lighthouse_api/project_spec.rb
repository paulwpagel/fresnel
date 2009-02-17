require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/project"

describe Lighthouse::LighthouseApi::Project, "users" do
  before(:each) do
    @lighthouse_project = mock("Lighthouse::Project", :id => 12345, :milestones => [])
    @users = [mock("user", :name => "user one", :id => "id one"), mock("user", :name => "user two", :id => "id two")]
    Lighthouse::LighthouseApi::ProjectMembership.stub!(:all_users_for_project).and_return(@users)
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end

  it "should find all users on init" do
    Lighthouse::LighthouseApi::ProjectMembership.should_receive(:all_users_for_project).with(12345).and_return([])
    
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
  
  it "should return the user names" do  
    @fresnel_project.user_names.should == ["user one", "user two"]
  end
  
  it "should get the id of a user from the name for the first user" do
    @fresnel_project.user_id("user one").should == "id one"
  end
  
  it "should get the id of a user from the name for the second user" do
    @fresnel_project.user_id("user two").should == "id two"
  end
  
  it "should return nil if the given user name doesn't exist" do
    @fresnel_project.user_id("bad name").should be_nil
  end
  
  it "should return the name of a user given the id" do
    @fresnel_project.user_name("id one").should == "user one"
  end
  
  it "should get the name of a user from the id for the second user" do
    @fresnel_project.user_name("id two").should == "user two"
  end
  
  it "should return nil if the given user id doesn't exist" do
    @fresnel_project.user_id("bad id").should be_nil
  end
end

describe Lighthouse::LighthouseApi::Project, "tags" do
  before(:each) do
    Lighthouse::LighthouseApi::ProjectMembership.stub!(:all_users_for_project).and_return([])
    @lighthouse_project = mock("Lighthouse::Project", :milestones => [], :id => 12345)
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
  
  it "should get zero tag names" do
    @lighthouse_project.stub!(:tags).and_return([])
    
    @fresnel_project.tag_names.should == []
  end
  
  it "should get one tag name" do
    @lighthouse_project.stub!(:tags).and_return([mock("tag", :name => "Tag One")])
    
    @fresnel_project.tag_names.should == ["Tag One"]
  end
  
  it "should get two tag names" do
    @lighthouse_project.stub!(:tags).and_return([mock("tag", :name => "Tag One"), mock("tag", :name => "Tag Two")])
    
    @fresnel_project.tag_names.should == ["Tag One", "Tag Two"]
  end
end

describe Lighthouse::LighthouseApi::Project, "tickets" do
  before(:each) do
    Lighthouse::LighthouseApi::ProjectMembership.stub!(:all_users_for_project).and_return([])
    @lighthouse_project = mock("Lighthouse::Project", :milestones => [], :id => 12345, :open_states_list => "new,open")
  end
  
  it "should find all tickets on init" do
    Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(anything(), "all")
    
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end

  describe Lighthouse::LighthouseApi::Project, "with tickets" do
    before(:each) do
      @ticket_one = ticket(:state => "open", :tags => ["one"], :id => 1)
      @ticket_two = ticket(:state => "resolved", :tags => ["one", "two"], :id => 2)
      @ticket_three = ticket(:state => "open", :tags => [], :id => 3)
      @ticket_four = ticket(:state => "new", :tags => ["two"], :id => 4)
      @tickets = [@ticket_one, @ticket_two, @ticket_three, @ticket_four]
      Lighthouse::LighthouseApi::Ticket.stub!(:find_tickets).and_return(@tickets)
      @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
    end
  
    it "should return all tickets" do
      @fresnel_project.all_tickets.should == @tickets    
    end
  
    it "should return open tickets" do
      @fresnel_project.open_tickets.should == [@ticket_one, @ticket_three, @ticket_four]
    end
    
    it "should get tickets for a certain tag" do
      tickets = @fresnel_project.tickets_for_tag("one")
      tickets.should == [@ticket_one, @ticket_two]
    end
    
    it "should update the cached tickets" do
      Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(@fresnel_project, "all").and_return(@tickets)
      
      @fresnel_project.update_tickets
      
      @fresnel_project.all_tickets.should == @tickets
    end
    
    it "should have an id" do
      @fresnel_project.id.should == 12345
    end
    
    it "should delete the first ticket" do
      @ticket_one.should_receive(:destroy)
      @fresnel_project.destroy_ticket(1)
    end

    it "should delete the second ticket" do
      @ticket_two.should_receive(:destroy)
      @fresnel_project.destroy_ticket(2)
    end
    
    it "should update the tickets on destroy_ticket after deleting the ticket" do
      @ticket_one.should_receive(:destroy).ordered
      Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(@fresnel_project, "all").ordered.and_return(@tickets)
      
      @fresnel_project.destroy_ticket(1)
    end
    
    def ticket(options)
      return mock("ticket", options)
    end
  end
end

describe Lighthouse::LighthouseApi::Project, "milestones" do
  before(:each) do
    Lighthouse::LighthouseApi::ProjectMembership.stub!(:all_users_for_project).and_return([])
    milestone_one = mock("milestone", :title => "Goal One", :id => "id_one")
    @milestones = [milestone_one]
    @lighthouse_project = mock("Lighthouse::Project", :id => nil, :milestones => @milestones)
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
  
  it "should return the milestones for a project" do
    @fresnel_project.milestones.should == @milestones
  end
  
  it "should have a title for one milestone" do    
    @fresnel_project.milestone_titles.should == ["Goal One"]
  end
  
  it "should have a title for two milestones" do
    milestone_two = mock("milestone", :title => "Goal Two")
    @milestones << milestone_two
    
    @fresnel_project.milestone_titles.should == ["Goal One", "Goal Two"]
  end
  
  it "should get an id from a milestone title" do
    @fresnel_project.milestone_id("Goal One").should == "id_one"
  end
  
  it "should get an id for a different mileston" do
    milestone_two = mock("milestone", :title => "Goal Two", :id => "id_two")
    @milestones << milestone_two
    
    @fresnel_project.milestone_id("Goal Two").should == "id_two"
  end
  
  it "should return nil if it cannot find the title" do
    @fresnel_project.milestone_id("Bad Title").should be_nil
  end
  
  it "should have a way to get the first milestone title from the id" do
    @fresnel_project.milestone_title("id_one").should == "Goal One"
  end

  it "should have a way to get the second milestone title from the id" do
    milestone_two = mock("milestone", :title => "Goal Two", :id => "id_two")
    @milestones << milestone_two
    
    @fresnel_project.milestone_title("id_two").should == "Goal Two"
  end
  
  it "should return nil if it cannot find the milestone" do
    @fresnel_project.milestone_title("Bad ID").should be_nil
  end
    
end

describe Lighthouse::LighthouseApi::Project, "states" do
  before(:each) do
    Lighthouse::LighthouseApi::ProjectMembership.stub!(:all_users_for_project).and_return([])
    @lighthouse_project = mock("Lighthouse::Project", :id => nil, :milestones => [], :open_states_list => "one,two,three",
                                                      :closed_states_list => "closed_one,closed_two,closed_three")
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
  
  it "should get the open_states" do
    @fresnel_project.open_states.should == ["one", "two", "three"]
  end
  
  it "should get the closed_states" do
    @fresnel_project.closed_states.should == ["closed_one", "closed_two", "closed_three"]
  end
  
  it "should get all the states" do
    @fresnel_project.all_states.should == ["one", "two", "three", "closed_one", "closed_two", "closed_three"]
  end
end

describe Lighthouse::LighthouseApi::Project, "hyphenated_name" do
  before(:each) do
    @lighthouse_project = mock("Lighthouse::Project", :id => nil, :milestones => [])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
  
  it "should return the name if it is a single lowercase word" do
    @lighthouse_project.stub!(:name).and_return("lowercase")
    
    @fresnel_project.hyphenated_name.should == "lowercase"
  end
  
  it "should downcase the name" do
    @lighthouse_project.stub!(:name).and_return("UPPERCASE")
    
    @fresnel_project.hyphenated_name.should == "uppercase"
  end
  
  it "should replace spaces with hyphens" do
    @lighthouse_project.stub!(:name).and_return("Test Project One")
    
    @fresnel_project.hyphenated_name.should == "test-project-one"
  end
  
  it "should return the unformatted name" do
    @lighthouse_project.stub!(:name).and_return("Test Project")
    
    @fresnel_project.name.should == "Test Project"
  end
end