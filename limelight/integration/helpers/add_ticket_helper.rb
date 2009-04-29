require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module AddTicketHelper
  
  def add_ticket(producer)
    scene = current_scene(producer)

    scene.find("add_ticket_button").mouse_clicked(nil)
    
    scene = current_scene(producer)    
    scene.find("add_ticket_title").text = "Test Title One"
    scene.find("add_ticket_description").text = "Test Description One"
    scene.find("add_ticket_milestone").text = "First Milestone"

    press_button "submit_add_ticket_button", scene
  end
  
end