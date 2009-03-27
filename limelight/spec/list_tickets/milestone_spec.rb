require File.dirname(__FILE__) + '/../spec_helper'
require "milestone"

describe Milestone do
  before(:each) do
    @milestone, @scene, @production = create_player(Milestone, 
                                                :scene => {}, 
                                                :production => {})
    @milestone.stub!(:text)
    @milestone.ticket_lister.stub!(:filter_by_milestone)
    @milestone.milestone_lister.stub!(:activate)
    @milestone.stub!(:id)
  end
  
  it "should tell the ticket_lister to filter by milestone" do
    @milestone.should_receive(:text).and_return("Some Milestone")
    @milestone.ticket_lister.should_receive(:filter_by_milestone).with("Some Milestone")
    
    @milestone.filter
  end
  
  it "should activate the milestone" do
    @milestone.should_receive(:id).and_return("milestone_1")
    @milestone.milestone_lister.should_receive(:activate).with("milestone_1")

    @milestone.filter
  end
end