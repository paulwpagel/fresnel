require File.dirname(__FILE__) + '/../../spec_helper'
require "lighthouse/lighthouse_api/ticket_accessors"

class OldTicket
  attr_accessor :attribute_one, :attribute_two, :attribute_three
end
class NewTicket
  include TicketAccessors
  ticket_reader     :attribute_one
  ticket_writer     :attribute_two
  ticket_accessor   :attribute_three
  def initialize(old_ticket)
    @lighthouse_ticket = old_ticket
  end
end
describe TicketAccessors do
  before(:each) do
    @old_ticket = OldTicket.new
    @new_ticket = NewTicket.new(@old_ticket)
  end
  
  it "should have a ticket_reader method that allows you to read the attribute" do
    @old_ticket.attribute_one = "Some Value"
    @new_ticket.attribute_one.should == "Some Value"
  end
  
  it "should have a ticket_reader method that does not allow you to set the attribute" do
    lambda{@new_ticket.attribute_one = "New Value"}.should raise_error(NoMethodError)
  end
  
  it "should have a ticket_writer method that lets you set the value of the attribute" do
    @new_ticket.attribute_two = "New Value"
    @old_ticket.attribute_two.should == "New Value"
  end
  
  it "should have a ticket_writer method that does not allow you to read the value of the attribute" do
    @old_ticket.attribute_two = "Some Value"
    lambda{@new_ticket.attribute_two}.should raise_error(NoMethodError)
  end
  
  it "should have a ticket_accessor method that lets you both set and read the value of the attribute" do
    @old_ticket.attribute_three = "Some Value"
    @new_ticket.attribute_three.should == "Some Value"
    
    @new_ticket.attribute_three = "New Value"
    @old_ticket.attribute_three.should == "New Value"
  end
end