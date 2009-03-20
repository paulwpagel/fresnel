require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "add_ticket"

describe AddTicket, "#add" do

  before do
    @add_ticket = Object.new
    @add_ticket.extend(AddTicket)

    @ticket_lister = mock('ticket lister', :filter_by_type => nil)

    mock_stage_manager
    @scene = mock('scene', :ticket_lister => @ticket_lister, :text_for => '', :remove_children_of => nil, :stage => @stage)
    @add_ticket.stub!(:scene).and_return(@scene)

    @production = mock('production', :current_project => @project, :stage_manager => @stage_manager)
    @add_ticket.stub!(:production).and_return(@production)
  end
  
  context "adding ticket to lighthouse client" do
    
    it "should use the stage name to get the appropriate client" do
      @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)

      @add_ticket.add
    end
    
    it "sends correct ticket data" do
      title = 'a title'
      description = 'a description'
      person = 'joe'
      tags = 'some tags'
      milestone = 'milestones'

      @scene.stub!(:text_for).with("add_ticket_title").and_return(title)
      @scene.stub!(:text_for).with("add_ticket_description").and_return(description)
      @scene.stub!(:text_for).with("add_ticket_responsible_person").and_return(person)
      @scene.stub!(:text_for).with("add_ticket_tags").and_return(tags)
      @scene.stub!(:text_for).with("add_ticket_milestone").and_return(milestone)

      ticket_options = {}
      ticket_options[:title] = title
      ticket_options[:description] = description
      ticket_options[:assigned_user] = person
      ticket_options[:tags] = tags
      ticket_options[:milestone] = milestone
    
      @lighthouse_client.should_receive(:add_ticket).with(ticket_options, anything)
      
      @add_ticket.add
      
    end

    it "sends current project" do
      @lighthouse_client.should_receive(:add_ticket).with(anything, @project)
      
      @add_ticket.add
    end

  end
  
  it "should remove add_ticket_group's children when adding the ticket" do
    @scene.should_receive(:remove_children_of).with("add_ticket_group")

    @add_ticket.add
  end
  
  it "tells the project to update its tickets" do
    @project.should_receive(:update_tickets)
    
    @add_ticket.add
  end
  
  it "list open tickets" do
    @ticket_lister.should_receive(:filter_by_type).with("Open Tickets")
    
    @add_ticket.add
  end
    
end