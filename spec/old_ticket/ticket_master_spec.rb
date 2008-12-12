require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'
require "ticket_master"

describe TicketMaster, "when showing tickets" do
  
  before(:each) do
    @sut = Object.new
    @sut.extend(TicketMaster)
    
    @prop = mock("prop")
    Limelight::Prop.stub!(:new).and_return(@prop)
    
    @tickets = [mock("ticket", :title => nil, :id => "123", :state => nil)]
    @child = mock("prop", :add => nil)
    @scene = mock("scene", :find_by_name => [@child])
    @sut.stub!(:scene).and_return(@scene)
  end
  
  
  it "should make a prop for each ticket on the project" do
    Limelight::Prop.should_receive(:new).with(hash_including(:id => "ticket_123")).and_return(@prop)
    @sut.show_tickets @tickets
  end

  it "should use prop named 'main'" do
    @scene.should_receive(:find_by_name).with('main').and_return([@child])
    @sut.show_tickets @tickets
  end
  
  it "should add the prop to the scene" do
    @child.should_receive(:add).with(@prop)
    @sut.show_tickets @tickets
  end
  
end