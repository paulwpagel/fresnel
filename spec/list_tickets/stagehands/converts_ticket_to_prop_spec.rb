require File.dirname(__FILE__) + '/../../spec_helper'
require 'converts_ticket_to_prop'

describe ConvertsTicketToProp, "when converting a ticket to a prop" do
  before(:each) do
    @ticket = mock('ticket', :id => 123, 
                              :title => 'great hokey bug',
                              :state => 'extremely unhappy')
    @prop = mock("prop", :add => nil)
    Limelight::Prop.stub!(:new).and_return(@prop)
  end
  
  it "should give it an appropriate id" do
    Limelight::Prop.should_receive(:new).with(hash_including(:id => "ticket_123")).and_return(@prop)
    ConvertsTicketToProp.convert(@ticket)
  end

  it "should give it a name" do
    Limelight::Prop.should_receive(:new).with(hash_including(:name => "ticket_in_list")).and_return(@prop)
    ConvertsTicketToProp.convert(@ticket)
  end
  
  it "should set the player" do
    Limelight::Prop.should_receive(:new).with(hash_including(:players => "list_tickets")).and_return(@prop)
    ConvertsTicketToProp.convert(@ticket)
  end
  
  it "should set on_mouse_clicked" do
    Limelight::Prop.should_receive(:new).with(hash_including(:on_mouse_clicked => "view(123)")).and_return(@prop)
    ConvertsTicketToProp.convert(@ticket)
  end
  
  it "should return the main prop" do
    ConvertsTicketToProp.convert(@ticket).should == @prop
  end
  
  describe "title prop" do    
    it "should have text" do
      Limelight::Prop.should_receive(:new).with(hash_including(:text => "great hokey bug"))
      ConvertsTicketToProp.convert(@ticket)
    end
    
    it "should have a name" do
      Limelight::Prop.should_receive(:new).with(hash_including(:name => "ticket_title"))
      ConvertsTicketToProp.convert(@ticket)
    end
    
    it "should add it to the first prop" do
      title_prop = mock("title prop")
      Limelight::Prop.should_receive(:new).with(hash_including(:text => "great hokey bug")).and_return(title_prop)
      @prop.should_receive(:add).with(title_prop)
      
      ConvertsTicketToProp.convert(@ticket)
    end
  end
  
  describe "state prop" do    
    it "should have text" do
      Limelight::Prop.should_receive(:new).with(hash_including(:text => "extremely unhappy"))
      ConvertsTicketToProp.convert(@ticket)
    end
    
    it "should have a name" do
      Limelight::Prop.should_receive(:new).with(hash_including(:name => "ticket_state"))
      ConvertsTicketToProp.convert(@ticket)
    end
    
    it "should add it to the first prop" do
      title_prop = mock("title prop")
      Limelight::Prop.should_receive(:new).with(hash_including(:text => "extremely unhappy")).and_return(title_prop)
      @prop.should_receive(:add).with(title_prop)
      
      ConvertsTicketToProp.convert(@ticket)
    end
  end
  
end