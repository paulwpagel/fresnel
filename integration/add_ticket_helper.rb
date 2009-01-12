require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

module AddTicketHelper
  
  def add_ticket(producer)
    scene = current_scene(producer)

    press_button "add_ticket", scene
    
    scene = current_scene(producer)
    scene.name.should == "add_ticket"
    
    scene.find("title").text = "Test Title One"
    scene.find("description").text = "Test Description One"
    scene.find("milestones").text = "First Milestone"

    press_button "add_ticket_button", scene
  end
  
end