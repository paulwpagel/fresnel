require File.dirname(__FILE__) + '/../../spec_helper'
require "ticket_master"

describe TicketMaster, "tickets_for_type_and_tag" do
  before(:each) do
    @ticket_one = mock("ticket_one")
    @ticket_two = mock("ticket_two")
    @ticket_three = mock("ticket_three")
    @ticket_four = mock("ticket_four")
    @ticket_five = mock("ticket_five")
    
    @tickets_for_type = [@ticket_one, @ticket_two, @ticket_three]
    @tickets_for_tag = [@ticket_two, @ticket_three, @ticket_four]
    @tickets_for_milestone = [@ticket_two, @ticket_three, @ticket_five]
    @all_tickets = [@ticket_one, @ticket_two, @ticket_three, @ticket_four, @ticket_five]

    mock_stage_manager
    @project.stub!(:tickets_for_type).and_return(@all_tickets)
    @project.stub!(:tickets_for_tag).and_return(@all_tickets)
    @project.stub!(:tickets_for_milestone).and_return(@all_tickets)
    @project.stub!(:all_tickets).and_return(@all_tickets)
    @scene = mock("scene", :production => mock("production", :stage_manager => @stage_manager), :stage => @stage)
    
    @ticket_master = TicketMaster.new(@scene)
  end
  
  it "should get the project based on the stage" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @ticket_master.matching_tickets({})
  end
  
  it "should return all tickets if both values are nil" do    
    @ticket_master.matching_tickets({:type => nil, :tag => nil}).should == @all_tickets
  end
  
  context "type only" do
    before(:each) do
      @project.stub!(:tickets_for_type).and_return(@tickets_for_type)
    end
    
    it "should query the project for the tickets based on type" do
      @project.should_receive(:tickets_for_type).with("Some Type").and_return(@tickets_for_type)
      
      @ticket_master.matching_tickets({:type => "Some Type", :tag => nil})
    end
    
    it "should not query for attributes that are nil" do
      @project.should_not_receive(:tickets_for_tag)
      
      @ticket_master.matching_tickets({:type => "Some Type", :tag => nil})
    end

    it "should return those tickets" do
      @ticket_master.matching_tickets({:type => "Some Type", :tag => nil}).should == @tickets_for_type
    end
  end
  context "tag only" do
    before(:each) do
      @project.stub!(:tickets_for_tag).and_return(@tickets_for_tag)
    end

    it "should use the tag to get the tickets from the project" do
      @project.should_receive(:tickets_for_tag).with("Some Tag").and_return(@tickets_for_tag)
      
      @ticket_master.matching_tickets({:type => nil, :tag => "Some Tag"})
    end
    
    it "should return the tickets returned by the project" do
      @ticket_master.matching_tickets({:type => nil, :tag => "Some Tag"}).should == @tickets_for_tag
    end
  end
  context "milestone only" do
    before(:each) do
      @project.stub!(:tickets_for_milestone).and_return(@tickets_for_milestone)
    end
    
    it "should use the milestone to get the tickets from the project" do
      @project.should_receive(:tickets_for_milestone).with("Some Milestone").and_return(@tickets_for_milestone)
      
      @ticket_master.matching_tickets({:milestone => "Some Milestone"})
    end
    
    it "should return the tickets matching the milestone" do
      @ticket_master.matching_tickets({:milestone => "Some Milestone"}).should == @tickets_for_milestone
    end
    
  end
  
  context "both tag and type" do
    context "Open Tickets" do
      before(:each) do
        @project.stub!(:tickets_for_tag).and_return(@tickets_for_tag)
        @project.stub!(:tickets_for_type).and_return(@tickets_for_type)
        @tickets_for_type_and_tag = [@ticket_two, @ticket_three]
      end
      
      it "returns tickets that match the tag" do
        @ticket_master.matching_tickets({:type => "Open Tickets", :tag => "A tag to match"}).should == @tickets_for_type_and_tag
      end
    end
  end
  
  context "bad attribute" do
    it "should handle attributes that don't exist" do
      @project.should_receive(:tickets_for_bad_attribute).and_raise(NoMethodError)
      
      @ticket_master.matching_tickets({:bad_attribute => "doesn't matter"}).should == @all_tickets
    end
  end
end