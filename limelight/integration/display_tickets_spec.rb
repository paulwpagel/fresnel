require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")

describe "Display Tickets Integration Test" do
  include LoginHelper
  
  before(:each) do
    Lighthouse::Ticket.destroy_all
    create_ticket(:project_id => current_project.id, :title => "Ticket on Project One", :tag => "bug")
    create_ticket(:project_id => current_project.id, :title => "A Ticket", :state => "open")
    create_ticket(:project_id => current_project.id, :title => "B Ticket", :state => "resolved", :tag => "bug")
    create_ticket(:project_id => current_project.id, :title => "Test Title One")
    create_ticket(:project_id => current_project.id, :title => "C Ticket", :state => "hold")
    
    view_tickets
  end
  
  it "should default to tickets that are only in the open states for the project" do
    ticket_rows.size.should == current_project.open_tickets.size
    ticket_states.each do |state|
      current_project.open_states.should include(state)
    end
  end
  
  it "should toggle the list of tickets from the drop down to all tickets" do
    @scene.find("ticket_type").value = "All Tickets"
    ticket_rows.size.should == current_project.all_tickets.size
  end
  
  it "should sort tickets by the appropriate attribute by clicking on the column header" do
    @scene.find("ticket_type").value = "All Tickets"
    @scene.find("title_header").mouse_clicked(nil)
    ticket_titles.should == ["A Ticket", "B Ticket", "C Ticket", "Test Title One", "Ticket on Project One"]
    @scene.find("state_header").mouse_clicked(nil)
    ticket_states.should == ["resolved", "open", "new", "new", "hold"]
    @scene.find("state_header").mouse_clicked(nil)
    ticket_states.should == ["hold", "new", "new", "open", "resolved"]
  end
  
  it "should display the results of a search" do
    @scene.find("search_box").text = "new"
    @scene.find("search_button").button_pressed(nil)
    ticket_rows.size.should == 2
    ticket_states.should == ["new", "new"]
  end
  
  it "should filter on tag then type" do
    @scene.find("tag_1").mouse_clicked(nil)
    ticket_titles.should == ["Ticket on Project One"]
    @scene.find("ticket_type").value = ["All Tickets"]
    ticket_titles.should == ["Ticket on Project One", "B Ticket"]
    @scene.find("ticket_type").value = "Open Tickets"
    ticket_titles.should == ["Ticket on Project One"]
    
    @scene.find("all_tags").mouse_clicked(nil)
    ticket_titles.should == ["Ticket on Project One", "A Ticket", "Test Title One"]
  end
  
  def ticket_states
    ticket_rows.collect do |ticket_row|
      state_prop = ticket_row.children.find { |child| child.name == "ticket_state" }
      state_prop.text
    end
  end
  
  def ticket_titles
    ticket_rows.collect do |ticket_row|
      title_prop = ticket_row.children.find { |child| child.name == "ticket_title" }
      title_prop.text
    end
  end
  
  def current_project
    producer.production.stage_manager["default"].current_project
  end
  
  def ticket_rows
    @scene.find("ticket_lister").children
  end
  
  def view_tickets
    @scene = producer.open_scene("login", producer.theater["default"])    
    login_with_credentials(@scene)
    @scene = producer.production.theater['default'].current_scene
  end
  
  def create_ticket(options={})
    ticket = Lighthouse::Ticket.new(options)
    ticket.save
    return ticket
  end
  
end