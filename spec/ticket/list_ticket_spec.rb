require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "list_ticket"

describe ListTicket do  
  before(:each) do
    @project = mock('project', :all_tickets => [])    
    @lighthouse_client = mock('lighthouse_client', :find_project => @project)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)


    @sut = Object.new
    @sut.extend(ListTicket)
    
    @sut.stub!(:value).and_return('All Tickets')
  end

  def call_it
    @sut.update_ticket_list
  end

  
  it "should ask for a new client" do
    LighthouseClient.should_receive(:new).and_return(@lighthouse_client)
    call_it
  end
  
  it "should ask the client for the project" do
    @lighthouse_client.should_receive(:find_project).with('fresnel').and_return(@project)
    call_it
  end
  
  context "when value is All Tickets" do
    it "should ask the project for all tickets" do
      @sut.stub!(:value).and_return('All Tickets')
      @project.should_receive(:all_tickets)
      call_it
    end
  end
  
  context "when value is Open Tickets" do
    it "should ask the project for open tickets" do
      @sut.stub!(:value).and_return('Open Tickets')
      @project.should_receive(:open_tickets)
      call_it
    end
  end
  
  
  
  
end