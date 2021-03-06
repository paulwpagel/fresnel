require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/project"

describe Lighthouse::LighthouseApi::Project, "users" do
  before(:each) do
    @lighthouse_project = mock("Lighthouse::Project", :id => 12345, :milestones => [], :tags => [])
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
  end
  
  it "should get zero tag names" do
    @lighthouse_project.stub!(:tags).and_return([])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
    
    @fresnel_project.tag_names.should == []
  end
  
  it "should get one tag name" do
    @lighthouse_project.stub!(:tags).and_return([mock("tag", :name => "Tag One")])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
    
    @fresnel_project.tag_names.should == ["Tag One"]
  end
  
  it "should get two tag names" do
    @lighthouse_project.stub!(:tags).and_return([mock("tag", :name => "Tag One"), mock("tag", :name => "Tag Two")])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
    
    @fresnel_project.tag_names.should == ["Tag One", "Tag Two"]
  end
  
  it "should cache the tags on init" do
    @lighthouse_project.should_receive(:tags).and_return([])
    
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
end

describe Lighthouse::LighthouseApi::Project, "tickets" do
  before(:each) do
    milestone_one = mock("milestone", :id => 123, :title => "Title One")
    milestone_two = mock("milestone", :id => 456, :title => "Title Two")
    milestone_three = mock("milestone", :id => 789, :title => "Title Three")
    Lighthouse::LighthouseApi::ProjectMembership.stub!(:all_users_for_project).and_return([])
    @lighthouse_project = mock("Lighthouse::Project", :milestones => [milestone_one, milestone_two, milestone_three], :id => 12345, :open_states_list => "new,open", :tags => [])
  end
  
  it "should find all tickets on init" do
    Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(anything(), "all")
    
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end

  describe Lighthouse::LighthouseApi::Project, "with tickets" do
    before(:each) do
      @ticket_one = ticket(:state => "open", :tags => ["one"], :id => 1, :destroy => nil, :title => "Ticket One", :milestone_id => 123)
      @ticket_two = ticket(:state => "resolved", :tags => ["one", "two"], :id => 2, :title => "Ticket Two", :milestone_id => 123)
      @ticket_three = ticket(:state => "open", :tags => [], :id => 3, :title => "Ticket Three", :milestone_id => 456)
      @ticket_four = ticket(:state => "new", :tags => ["two"], :id => 4, :title => "Ticket Four", :milestone_id => 789)
      @tickets = [@ticket_one, @ticket_two, @ticket_three, @ticket_four]
      Lighthouse::Ticket.stub!(:find).and_return(@ticket_one)
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
    
    it "should find the ticket to delete by its id and the project id" do
      Lighthouse::Ticket.should_receive(:find).with(1, :params => {:project_id => 12345}).and_return(@ticket_one)

      @fresnel_project.destroy_ticket(1)
    end

    it "should delete the found ticket" do
      @ticket_one.should_receive(:destroy)
      
      @fresnel_project.destroy_ticket(1)
    end
    
    it "should update the tickets on destroy_ticket after deleting the ticket" do
      @ticket_one.should_receive(:destroy).ordered
      Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(@fresnel_project, "all").ordered.and_return(@tickets)
      
      @fresnel_project.destroy_ticket(1)
    end
    
    it "should return the title of the first ticket given its id" do
      @fresnel_project.ticket_title(1).should == "Ticket One"
    end
    
    it "should the title of the second ticket" do
      @fresnel_project.ticket_title(2).should == "Ticket Two"
    end
    
    it "should find the title if the id is passed in as a string" do
      @fresnel_project.ticket_title("1").should == "Ticket One"
    end
    
    it "should return nothing if the ticket is not found" do
      @fresnel_project.ticket_title("bad id").should be_nil
    end
    
    it "should find  open tickets" do
      @fresnel_project.tickets_for_type("Open Tickets").should == [@ticket_one, @ticket_three, @ticket_four]
    end
    
    it "should return all tickets" do
      @fresnel_project.tickets_for_type("All Tickets").should == [@ticket_one, @ticket_two, @ticket_three, @ticket_four]
    end
    
    it "should return all tickets if given a bad type" do
      @fresnel_project.tickets_for_type(nil).should == [@ticket_one, @ticket_two, @ticket_three, @ticket_four]
    end
    
    describe "tickets_for_milestone" do
      it "should return tickets for the first milestone" do
        @fresnel_project.tickets_for_milestone("Title One").should == [@ticket_one, @ticket_two]
      end
      
      it "should return tickets for the second milestone" do
        @fresnel_project.tickets_for_milestone("Title Two").should == [@ticket_three]
      end
      
      it "should return tickets for the third milestone" do
        @fresnel_project.tickets_for_milestone("Title Three").should == [@ticket_four]
      end
      
      it "should return all_tickets if the milestone does not exist" do
        @fresnel_project.tickets_for_milestone("Bad Title").should == [@ticket_one, @ticket_two, @ticket_three, @ticket_four]
      end
      
      it "should return all_tickets if the milestone is nil" do
        @fresnel_project.tickets_for_milestone(nil).should == [@ticket_one, @ticket_two, @ticket_three, @ticket_four]
      end
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
    @lighthouse_project = mock("Lighthouse::Project", :id => nil, :milestones => @milestones, :tags => [])
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
                                                      :closed_states_list => "closed_one,closed_two,closed_three", :tags => [])
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
    @lighthouse_project = mock("Lighthouse::Project", :id => nil, :milestones => [], :tags => [])
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

def create_mock_milestones
  @milestone_one = mock("milestone", :id => 123, :attribute= => nil, :save => nil)
  @milestone_two = mock("milestone", :id => 456, :save => nil)
  @milestone_three = mock("milestone", :id => 789, :save => nil)
  @milestones = [@milestone_one, @milestone_two, @milestone_three]
end

describe Lighthouse::LighthouseApi::Project, "milestone manipulation" do
  before(:each) do
    @new_milestone = mock(Lighthouse::Milestone)
    Lighthouse::Milestone.stub!(:find).and_return([@new_milestone])
    
    create_mock_milestones
    @lighthouse_project = mock("Lighthouse::Project", :id => 12345, :milestones => @milestones, :tags => [])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
  
  describe "create_milestone" do
    before(:each) do
      Lighthouse::Milestone.stub!(:create).and_return(@new_milestone)
    end

    it "should it create a milestone with the given options" do
      options = {:title => "some title", :goals => "my goals"}
      Lighthouse::Milestone.should_receive(:create).with(hash_including(options))
    
      @fresnel_project.create_milestone(options)
    end
  
    it "should include the project id with the options" do
      Lighthouse::Milestone.should_receive(:create).with(hash_including(:project_id => 12345))
    
      @fresnel_project.create_milestone({})
    end
  
    it "should return the created milestone" do
      @fresnel_project.create_milestone({}).should == @new_milestone
    end
  
    it "should update the project's list of milestones" do
      Lighthouse::Milestone.should_receive(:find).with(:all, :params => { :project_id => 12345 }).and_return([@new_milestone])
    
      @fresnel_project.create_milestone({})
    
      @fresnel_project.milestones.should == [@new_milestone]
    end
  
    it "should call call observe on the milestone_observers" do
      @observer = mock("observer")
      @fresnel_project.register_milestone_observer(@observer)
      @observer.should_receive(:observe)
    
      @fresnel_project.create_milestone({})
    end
  end
  
  describe "delete_milestone" do
    before(:each) do
      Lighthouse::Milestone.stub!(:delete)
    end
    
    it "should call the delete on milestone passing in the id and project id" do
      Lighthouse::Milestone.should_receive(:delete).with("milestone_id", {:project_id => 12345})
    
      @fresnel_project.delete_milestone("milestone_id")
    end
  
    it "should update the list of milestones on the project" do
      Lighthouse::Milestone.should_receive(:find).with(:all, :params => { :project_id => 12345 }).and_return([@new_milestone])

      @fresnel_project.delete_milestone("milestone_id")

      @fresnel_project.milestones.should == [@new_milestone]
    end
  
    it "should call call observe on the milestone_observers" do
      @observer = mock("observer")
      @fresnel_project.register_milestone_observer(@observer)
      @observer.should_receive(:observe)
    
      @fresnel_project.delete_milestone("milestone_id")
    end
  end
  
  describe "update_milestone" do
    it "should work with no attributes" do
      @milestone_one.should_not_receive(:attribute=)
      
      @fresnel_project.update_milestone(123, {})
    end
    
    it "should update the milestone with the given attributes" do
      @milestone_one.should_receive(:attribute=).with("new value")
      
      @fresnel_project.update_milestone(123, {:attribute => "new value"})
    end
    
    it "should work for a different milestone id" do
      @milestone_two.should_receive(:different_attribute=).with("new value")
      
      @fresnel_project.update_milestone(456, {:different_attribute => "new value"})
    end
    
    it "should not crash if it cannot find the milestone from the id" do
      lambda{@fresnel_project.update_milestone("bad_id", {:attribute => "new value"})}.should_not raise_error
    end
    
    it "should save the milestone" do
      @milestone_one.should_receive(:save)
      
      @fresnel_project.update_milestone(123, {})
    end
    
    it "should update the entire list of milestones" do
      Lighthouse::Milestone.should_receive(:find).with(:all, :params => { :project_id => 12345 }).and_return([@new_milestone])
    
      @fresnel_project.update_milestone(123, {})
    
      @fresnel_project.milestones.should == [@new_milestone]
    end
  end
  
  describe "milestone_from_id" do
    it "should get the first milestone" do
      @fresnel_project.milestone_from_id(123).should == @milestone_one
    end
    
    it "should get the second milestone" do
      @fresnel_project.milestone_from_id(456).should == @milestone_two
    end
    
    it "should get the third milestone" do
      @fresnel_project.milestone_from_id(789).should == @milestone_three
    end
    
    it "should return nil for a bad id" do
      @fresnel_project.milestone_from_id("bad id").should be_nil
    end
  end
end

describe Lighthouse::LighthouseApi::Project, "milestone observer" do
  before(:each) do
    @observer = mock("observer")
    
    @lighthouse_project = mock("Lighthouse::Project", :id => 12345, :milestones => [], :tags => [])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthouse_project)
  end
    
  it "should call observe on one registered observer" do
    @fresnel_project.register_milestone_observer(@observer)
    @observer.should_receive(:observe)

    @fresnel_project.observe_milestones
  end
  
  it "should not crash with no observers" do
    lambda{@fresnel_project.observe_milestones}.should_not raise_error
  end
end