require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/project_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/add_ticket_helper")

describe "Add Ticket Integration Test" do
  include LoginHelper
  include ProjectHelper
  include AddTicketHelper
  
  it "should view a ticket" do
    Lighthouse::Ticket.destroy_all
    go_to_ticket
    
    scene = current_scene(producer)
    scene.find("ticket_title").text.should == "Test Title One"
    scene.find("ticket_state").value.should == "new"
    scene.find("ticket_description").text.should == "Test Description One"
    scene.find("ticket_milestone").value.should == "First Milestone"
  end
  
  def go_to_ticket
    scene = login_scene(producer)
     
    login_with_credentials(scene)
    
    scene = current_scene(producer)
    
    scene.name.should == "list_tickets"
    
    add_ticket(producer)
    
    scene = current_scene(producer)
    

    scene.find("ticket_type").value = "All Tickets"

    scene.find("ticket_lister").children.first.mouse_clicked(nil)
  end
end