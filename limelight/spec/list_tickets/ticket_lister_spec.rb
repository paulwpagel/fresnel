require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "ticket_lister"
  
describe TicketLister, "when being told to show tickets" do

  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(TicketLister)
    @prop = mock('prop')
    ConvertsTicketToProp.stub!(:convert).and_return @prop
    
    @player_under_test.stub!(:add)
    @player_under_test.stub!(:remove_all)
    
    @tickets = [mock('ticket')]
  end
  
  def call_it
    @player_under_test.show_these_tickets(@tickets)
  end
  
  it "should make a prop for a single ticket" do    
    ConvertsTicketToProp.should_receive(:convert).with(@tickets[0])
    
    call_it
  end
  
  it "should work for multiple tickets" do
    @tickets << mock("ticket")
    
    ConvertsTicketToProp.should_receive(:convert).with(@tickets[1])
    
    call_it
  end
  
  it "should remove_all tickets before adding new tickets" do
    @player_under_test.should_receive(:remove_all).ordered
    @player_under_test.should_receive(:add).ordered
    
    call_it
  end
  
  it "should add the returned prop to itself" do
    @player_under_test.should_receive(:add).with(@prop)
    call_it
  end
  
  it "should keep track of the last tickets shown" do
    call_it
    
    @player_under_test.last_tickets.should == @tickets
  end
end

describe TicketLister, "remove_ticket with real props" do
  
  
  before(:each) do
    @ticket = mock("ticket", :id => "ticket_12345", :null_object => true)
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:current_ticket => @ticket})
  end
  
  it "should remove the prop" do
    @ticket_lister.should_receive(:children).and_return([@ticket])
    @ticket_lister.should_receive(:remove).with(@ticket)
    @ticket_lister.remove_ticket(12345)
  end
end

describe TicketLister, "cancel_edit_ticket" do
  
  before(:each) do
    mock_stage_manager
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
                                                
    @ticket_prop = mock('ticket props')
    @scene.stub!(:find).and_return(@ticket_prop)
    @ticket_prop.stub!(:remove_all)
    @ticket_prop.stub!(:hover_style=)
    @scene.stub!(:styles).and_return({})
    @new_prop = mock('new prop')
    @new_prop.stub!(:children).and_return([])
    ConvertsTicketToProp.stub!(:convert).and_return(@new_prop)
  end
  
  it "should get rid of the edit form" do    
    @stage_info.current_ticket.should_receive(:id).and_return("123456")
    @scene.should_receive(:find).with("ticket_123456").and_return(@ticket_prop)
    @ticket_prop.should_receive(:remove_all)

    @ticket_lister.cancel_edit_ticket
  end
  
  it "should re-add the ticket to the list" do
    @new_prop.should_receive(:children).and_return(["one", "two"])
    ConvertsTicketToProp.should_receive(:convert).with(@current_ticket).and_return(@new_prop)

    @ticket_prop.should_receive(:add).with("one")
    @ticket_prop.should_receive(:add).with("two")
    @ticket_lister.cancel_edit_ticket
  
  end
  
  it "should clear the current_ticket" do
    @stage_info.should_receive(:current_ticket=).with(nil)

    @ticket_lister.cancel_edit_ticket
  end
  
  it "should use the stage name to get the stage_info" do
    @stage_manager.should_receive(:[]).at_least(1).times.with("stage name").and_return(@stage_info)
    
    @ticket_lister.cancel_edit_ticket
  end
end

describe TicketLister, "search_on" do
  
  before(:each) do
    @ticket = mock("ticket", :id => "ticket_123456", :null_object => true)
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:current_ticket => @ticket, :current_ticket= => nil})
                                                
    @matching_ticket = mock("ticket", :id => 12345, :matches_criteria? => true, :null_object => true)
    @non_matching_ticket = mock("ticket", :id => 12346, :matches_criteria? => false, :null_object => true)
  end

  it "adds a ticket that matches criteria" do
    @ticket_lister.last_tickets = [@non_matching_ticket, @matching_ticket]
    @ticket_lister.should_receive(:show_these_tickets).with([@matching_ticket])

    @ticket_lister.search_on("does not matter")
  end
  
  it "should show these tickets" do
    @new_prop = mock('prop')

    @ticket_lister.should_receive(:remove_all)
    ConvertsTicketToProp.should_receive(:convert).with(@matching_ticket).and_return(@new_prop)
    @ticket_lister.should_receive(:add).with(@new_prop)
    @ticket_lister.show_these_tickets([@matching_ticket])
  end
end

describe TicketLister, "clear_tag_filter" do

  before(:each) do
    @ticket = mock("ticket", :id => "ticket_123456", :null_object => true)
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:current_ticket => @ticket, :current_ticket= => nil})
                                                
    @ticket_master = mock('ticket_master', :matching_tickets => [])
    @scene.stub!(:ticket_master).and_return(@ticket_master)
    @ticket_lister.stub!(:remove_all)
  end
  
  it "asks ticket_master for just the type" do
    
    @ticket_lister.current_type_filter = "A type"
    @ticket_lister.current_tag_filter = "A tag"

    
    @ticket_master.should_receive(:matching_tickets).with(hash_including({:type => "A type", :tag => nil})).and_return(['a'])
    @ticket_lister.should_receive(:show_these_tickets).with(['a'])

    @ticket_lister.clear_tag_filter
  end

  it "should clear the search text box" do
    @ticket_lister.search_box.should_receive(:text=).with("")

    @ticket_lister.clear_tag_filter
  end
end

describe TicketLister, "filter_by_type" do
  
  before(:each) do
    @ticket_master = mock('ticket_master', :matching_tickets => [])
    @ticket = mock("ticket", :id => "ticket_123456", :null_object => true)
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil, :ticket_master => @ticket_master}, 
                                                :production => {:current_ticket => @ticket, :current_ticket= => nil})
    @ticket_lister.stub!(:remove_all)
  end

  it "asks ticketmaster for the tickets for given type" do
    @ticket_lister.should_receive(:show_these_tickets).with([])
    @ticket_master.should_receive(:matching_tickets).with(hash_including(:type => "Some Tickets")).and_return([])
    
    @ticket_lister.filter_by_type("Some Tickets")
  end
  
  it "shows the tickets returned from ticketmaster" do
    @ticket_master.should_receive(:matching_tickets).with(hash_including(:type => "Some Tickets")).and_return(["a", "b"])
    @ticket_lister.should_receive(:show_these_tickets).with(["a", "b"])
    @ticket_lister.filter_by_type("Some Tickets")
  end
  
  context "already filtered_by_tag" do
    it "should keep track of the tag filter" do
      @ticket_lister.current_tag_filter = "A cool tag"
      
      @ticket_master.should_receive(:matching_tickets).with(hash_including({:type =>"Some Tickets", :tag => "A cool tag"})).and_return([])
      @ticket_lister.filter_by_type("Some Tickets")
    end
  end
  
  it "should clear the search text box" do
    @ticket_lister.search_box.should_receive(:text=).with("")
    
    @ticket_lister.filter_by_type("Some Tickets")
  end
  
end

describe TicketLister, "filter_by_tag" do
  
  before(:each) do
    @ticket_master = mock('ticket_master', :matching_tickets => [])
    @ticket = mock("ticket", :id => "ticket_123456", :null_object => true)
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil, :ticket_master => @ticket_master}, 
                                                :production => {:current_ticket => @ticket, :current_ticket= => nil})
    @ticket_lister.stub!(:remove_all)                                            
  end

  it "asks ticketmaster for the tickets for given type" do
    @ticket_lister.should_receive(:show_these_tickets).with([])
    @ticket_master.should_receive(:matching_tickets).with(hash_including(:tag => "Some Tickets")).and_return([])
    
    @ticket_lister.filter_by_tag("Some Tickets")
  end
  
  it "should clear the search text box" do
    @ticket_lister.search_box.should_receive(:text=).with("")
    @ticket_lister.filter_by_tag("A cool tag")
  end
  
end

describe TicketLister, "filter_by_milestone" do
  before(:each) do
    ConvertsTicketToProp.stub!(:convert)
    @matching_tickets = [mock("ticket")]
    @ticket_master = mock('ticket_master', :matching_tickets => @matching_tickets)
    @ticket = mock("ticket", :id => "ticket_123456", :null_object => true)
    @ticket_lister, @scene, @production = create_player(TicketLister, 
                                                :scene => {:load => nil, :find => nil, :ticket_master => @ticket_master}, 
                                                :production => {:current_ticket => @ticket, :current_ticket= => nil})
    @ticket_lister.stub!(:remove_all)
    @ticket_lister.stub!(:add)                                     
  end
  
  it "should get the tickets from the ticket_master" do
    @ticket_lister.should_receive(:show_these_tickets).with([])
    @ticket_master.should_receive(:matching_tickets).with(hash_including(:milestone => "Some Milestone")).and_return([])
    
    @ticket_lister.filter_by_milestone("Some Milestone")
  end
  
  it "should filter based on tag then milestone" do
    @ticket_lister.filter_by_tag("A cool tag")
    @ticket_master.should_receive(:matching_tickets).with(hash_including(:milestone => "Some Milestone", :tag => "A cool tag")).and_return([])
    
    @ticket_lister.filter_by_milestone("Some Milestone")
  end
end