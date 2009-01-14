require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/project_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/add_ticket_helper")
require 'limelight/specs/spec_helper'

describe "Add Ticket Integration Test" do
  include LoginHelper
  include ProjectHelper
  include AddTicketHelper
  
  it "should view a ticket" do
    go_to_ticket
    
    scene = current_scene(producer)
    scene.find("ticket_title").text.should == "Test Title One"
    scene.find("ticket_state").value.should == "new"
    scene.find("ticket_description").text.should == "Test Description One"
  end
  
  def go_to_ticket
    scene = login_scene(producer)
     
    login_with_credentials(scene)
    
    scene = current_scene(producer)
    
    scene.name.should == "project"
    scene.find("fresnel").mouse_clicked(nil)
    
    add_ticket(producer)
    
    scene = current_scene(producer)
    

    scene.find("ticket_type").value = "All Tickets"

    scene.find("ticket_lister").children.first.mouse_clicked(nil)
  end
end