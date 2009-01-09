module AddTicket
  
  def scene_opened(e)
    load_milestones
  end
  
  def button_pressed(e)
    add_ticket
  end
  
  def load_milestones
    milestone_input = scene.find("milestones")
    milestone_input.choices = milestone_choices
  end
    
  def add_ticket
    title = scene.find("title")
    description = scene.find("description")
  
    production.lighthouse_client.add_ticket({:title => title.text, :description => description.text}, "fresnel")
    
    title.text = ""
    description.text = ""
    
    scene.load("list_tickets")
  end
    
  private #############
  
  def project_id
    production.current_project.id
  end
  
  def milestone_choices
    milestones = production.lighthouse_client.milestones("fresnel") #TODO - PWP - we have the project name now, dont need to hard code anymore.
    choices = ["None"]
    choices += milestones.collect{ |milestone| milestone.title }
  end
    
end