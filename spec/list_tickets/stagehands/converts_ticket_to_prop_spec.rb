require File.dirname(__FILE__) + '/../../spec_helper'
require 'converts_ticket_to_prop'

describe ConvertsTicketToProp, "when converting a ticket to a prop" do
  before(:each) do
    @ticket = mock('ticket', :id => 123, 
                              :title => 'great hokey bug',
                              :state => 'extremely unhappy')
  end
  
  it "should give it an appropriate id" do
    Limelight::Prop.should_receive(:new).with(hash_including(:id => "ticket_123"))
    ConvertsTicketToProp.convert(@ticket)
  end

  it "should give it a name" do
    Limelight::Prop.should_receive(:new).with(hash_including(:name => "ticket_in_list"))
    ConvertsTicketToProp.convert(@ticket)
  end
  
  it "should give it text" do
    Limelight::Prop.should_receive(:new).with(hash_including(:text => "great hokey bug, State: extremely unhappy"))
    ConvertsTicketToProp.convert(@ticket)
  end
  
  it "should set the player" do
    Limelight::Prop.should_receive(:new).with(hash_including(:players => "list_tickets"))
    ConvertsTicketToProp.convert(@ticket)
  end
  
  it "should set on_mouse_clicked" do
    Limelight::Prop.should_receive(:new).with(hash_including(:on_mouse_clicked => "view(123)"))
    ConvertsTicketToProp.convert(@ticket)
  end
end