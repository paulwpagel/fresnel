require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "add_ticket"

describe AddTicket, "#add" do

  before do
    mock_stage_manager
    @add_ticket, @scene, @production = create_player(AddTicket, 
                                                :scene => {:load => nil, :find => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @add_ticket.ticket_lister.stub!(:filter_by_type)
    @add_ticket.add_ticket_group.stub!(:remove_all)
  end
  
  context "adding ticket to lighthouse client" do
    
    it "should use the stage name to get the appropriate stage_info" do
      @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)

      @add_ticket.add
    end

    it "should use the stage name to get the lighthouse_client" do
      @stage_manager.should_receive(:client_for_stage).with("stage name").at_least(1).times.and_return(@lighthouse_client)

      @add_ticket.add
    end
    
    it "sends correct ticket data" do
      title = 'a title'
      description = 'a description'
      person = 'joe'
      tags = 'some tags'
      milestone = 'milestones'

      @add_ticket.add_ticket_title.stub!(:text).and_return(title)
      @add_ticket.add_ticket_description.stub!(:text).and_return(description)
      @add_ticket.add_ticket_responsible_person.stub!(:value).and_return(person)
      @add_ticket.add_ticket_tags.stub!(:text).and_return(tags)
      @add_ticket.add_ticket_milestone.stub!(:value).and_return(milestone)

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
    @add_ticket.add_ticket_group.should_receive(:remove_all)

    @add_ticket.add
  end
  
  it "tells the project to update its tickets" do
    @project.should_receive(:update_tickets)
    
    @add_ticket.add
  end
  
  it "list open tickets" do
    @add_ticket.ticket_lister.should_receive(:filter_by_type).with("Open Tickets")
    
    @add_ticket.add
  end
    
end