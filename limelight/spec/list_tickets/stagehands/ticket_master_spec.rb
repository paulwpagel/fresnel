require File.dirname(__FILE__) + '/../../spec_helper'
require "ticket_master"

# describe TicketMaster, "filter_by_type" do
#   
#   before(:each) do
#     @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
#     @tickets = [mock('ticket')]
#     @project = mock("project", :all_tickets => @tickets, :open_tickets => nil)
#     @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :current_project => @project))
#     
#     @ticket_master = TicketMaster.new(@scene)
#   end
#     
#   it "should get all_tickets from the project if All Tickets" do
#     @project.should_receive(:all_tickets)
#     
#     @ticket_master.filter_by_type("All Tickets")
#   end
#   
#   it "should get open_tickets from the project if Open Tickets" do
#     @project.should_receive(:open_tickets)
#     
#     @ticket_master.filter_by_type("Open Tickets")    
#   end
# 
#   it "should use the ticket lister to show the tickets" do
#     @ticket_lister.should_receive(:show_these_tickets).with(@tickets)
# 
#     @ticket_master.filter_by_type("All Tickets")
#   end
#   
#   it "should not crash if the ticket_lister is not on the screen" do
#     @scene.stub!(:ticket_lister).and_return(nil)
#     
#     lambda{@ticket_master.filter_by_type("Some Tickets")}.should_not raise_error
#   end
# end
# 
# describe TicketMaster, "filter_by_tag" do
#   before(:each) do
#     @tickets = [mock('ticket')]
#     @project = mock("project", :tickets_for_tag => @tickets, :all_tickets => @tickets)
#     @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
#     @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :current_project => @project))
#     
#     @ticket_master = TicketMaster.new(@scene)
#   end
#   
#   it "should have a filter_by_tag method" do
#     @ticket_master.filter_by_tag("some tag")
#   end
# 
#   it "should get the tickets to show from the current_project" do
#     @project.should_receive(:tickets_for_tag).with("Tag One").and_return([])
#     
#     @ticket_master.filter_by_tag("Tag One")
#   end
#   
#   it "should show the found tickets" do
#     @ticket_lister.should_receive(:show_these_tickets).with(@tickets)
#     
#     @ticket_master.filter_by_tag("Tag One")
#   end
#   
#   it "should not crash if the ticket_lister is not on the screen" do
#     @scene.stub!(:ticket_lister).and_return(nil)
#     
#     lambda{@ticket_master.filter_by_tag("Tag One")}.should_not raise_error
#   end
# end

describe TicketMaster, "tickets_for_type_and_tag" do
  before(:each) do
    @closed_ticket = mock("closed_ticket")
    @open_ticket = mock("open_ticket")
    @all_tickets = [@closed_ticket, @open_ticket]
    @open_tickets = [@open_ticket]
    @project = mock("project", :all_tickets => @all_tickets, :open_tickets => @open_tickets)
    @scene = mock("scene", :production => mock("production", :current_project => @project))
    
    @ticket_master = TicketMaster.new(@scene)
  end
  
  it "should return all tickets if both values are nil" do
    @ticket_master.tickets_for_type_and_tag(nil, nil).should == @all_tickets
  end
  
  context "no tag" do
    it "should return open tickets if 'Open Tickets' is passed as the type" do
      @ticket_master.tickets_for_type_and_tag("Open Tickets", nil).should == @open_tickets
    end

    it "should return all tickets if type is not 'Open Tickets' or 'All Tickets'" do
      @ticket_master.tickets_for_type_and_tag('I am a bad type', nil).should == @all_tickets
    end

    it "should return all tickets for a type of 'All Tickets" do
      @ticket_master.tickets_for_type_and_tag('All Tickets', nil).should == @all_tickets
    end

  end
  context "no type" do
    before(:each) do
      @tagged_ticket = mock("tagged_ticket")
      @project.stub!(:tickets_for_tag).with("Some Tag").and_return([@tagged_ticket])
    end

    it "should use the tag to get the tickets from the project" do
      @project.should_receive(:tickets_for_tag).with("Some Tag").and_return([])
      @ticket_master.tickets_for_type_and_tag(nil, "Some Tag")
    end
    it "should return the tickets returned by the project" do
      @ticket_master.tickets_for_type_and_tag(nil, "Some Tag").should == [@tagged_ticket]
    end
  end
  
  context "both tag and type" do
    context "Open Tickets" do
      before(:each) do
        @matching_tag_ticket = mock('matching_tag_ticket')
        @not_matching_tag_ticket = mock('not_matching_tag_ticket')
        @closed_matching_tag_ticket = mock('closed_matching_tag_ticket')
        @open_tickets << @matching_tag_ticket << @not_matching_tag_ticket
        @all_tickets << @closed_matching_tag_ticket
        @project.stub!(:tickets_for_tag).and_return([@matching_tag_ticket, @closed_matching_tag_ticket])
      end
      it "returns tickets that match the tag" do
        @ticket_master.tickets_for_type_and_tag("Open Tickets", "A tag to match").should include(@matching_tag_ticket)
      end
      it "does not return tickets that do not match the tag" do
        @ticket_master.tickets_for_type_and_tag("Open Tickets", "A tag to match").should_not include(@not_matching_tag_ticket)
      end
      it "does not return closed tagged tickets" do
        @ticket_master.tickets_for_type_and_tag("Open Tickets", "A tag to match").should_not include(@closed_matching_tag_ticket)
      end
    end
    
    context "All Tickets" do 
      before(:each) do
        @matching_tag_ticket = mock('matching_tag_ticket')
        @not_matching_tag_ticket = mock('not_matching_tag_ticket')
        @all_tickets << @matching_tag_ticket << @not_matching_tag_ticket
        
        @project.stub!(:tickets_for_tag).and_return([@matching_tag_ticket])
      end
      it "returns tickets that match the tag" do
        @ticket_master.tickets_for_type_and_tag("All Tickets", "A tag to match").should include(@matching_tag_ticket)
      end
      it "does not return tickets that do not match the tag" do
        @ticket_master.tickets_for_type_and_tag("All Tickets", "A tag to match").should_not include(@not_matching_tag_ticket)
      end
    end
  end
end

describe TicketMaster, "tickets_for_type" do
  before(:each) do
    @tickets = [mock('ticket')]
    @project = mock("project", :all_tickets => nil, :open_tickets => nil)
    @scene = mock("scene", :production => mock("production", :current_project => @project))
    
    @ticket_master = TicketMaster.new(@scene)
  end
    
  it "should get all_tickets from the project if All Tickets" do
    @project.should_receive(:all_tickets)
    
    @ticket_master.tickets_for_type("All Tickets")
  end
  
  it "should get open_tickets from the project if Open Tickets" do
    @project.should_receive(:open_tickets)
    
    @ticket_master.tickets_for_type("Open Tickets")    
  end
  
  it "should return the found tickets" do
    @project.stub!(:open_tickets).and_return(@tickets)
    
    @ticket_master.tickets_for_type("Open Tickets").should == @tickets
  end
end

describe TicketMaster, "show_all_tags" do
  before(:each) do
    @tickets = [mock('ticket')]
    @project = mock("project", :all_tickets => nil, :open_tickets => @tickets)
    @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
    @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :current_project => @project))
    
    @ticket_master = TicketMaster.new(@scene)
  end
  
  it "should show_all_tags" do
    @ticket_master.filter_by_type("Open Tickets")
    @ticket_lister.should_receive(:show_these_tickets).with(@tickets)
    
    @ticket_master.clear_tag_filter
  end
end

# describe TicketMaster, "type and tag working together" do
#   before(:each) do
#     @ticket1 = mock('ticket1')
#     @ticket2 = mock('ticket2')
#     @ticket3 = mock('ticket3')
#     @ticket4 = mock('ticket4')
#     @open_tickets = [@ticket1, @ticket2, @ticket3]
#     @tickets_for_tag = [@ticket2, @ticket3, @ticket4]
#     @all_tickets = [@ticket1, @ticket2, @ticket3, @ticket4]
#     @project = mock("project", :tickets_for_tag => @tickets_for_tag, :open_tickets => @open_tickets, :all_tickets => @all_tickets)
#     @ticket_lister = mock("ticket_lister", :show_these_tickets => nil)
#     @scene = mock("scene", :ticket_lister => @ticket_lister, :production => mock("production", :current_project => @project))
#     
#     @ticket_master = TicketMaster.new(@scene)
#   end
#   
#   it "should filter based on type then tag" do
#     @ticket_master.filter_by_type("Open Tickets")
#     @ticket_lister.should_receive(:show_these_tickets).with([@ticket2, @ticket3])
#     @ticket_master.filter_by_tag("some tag")
#   end
#   
#   it "should filter based on tag then type" do
#     @ticket_master.filter_by_tag("some tag")
#     @ticket_lister.should_receive(:show_these_tickets).with([@ticket2, @ticket3])
#     @ticket_master.filter_by_type("Open Tickets")
#   end
# end