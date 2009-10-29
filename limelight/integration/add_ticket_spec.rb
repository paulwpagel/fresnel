require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/project_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/add_ticket_helper")

describe "Add Ticket Integration Test" do
  include LoginHelper
  include ProjectHelper
  include AddTicketHelper
  
  it "should add a single ticket" do
    producer.production.production_opening
    scene = login_scene(producer)
     
    login_with_credentials(scene)
    
    scene = current_scene(producer)
    
    scene.name.should == "list_tickets"
    
    add_ticket(producer)
    
    scene = current_scene(producer)
    
    scene.find("ticket_type").text = "All Tickets"
  end
  
end