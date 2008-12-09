require "lighthouse_client"

module Ticket
  
  def scene_opened(e)
    load_milestones unless $testing
  end  

  def button_pressed(e)
    add_ticket
  end

  def load_milestones
    client = LighthouseClient.new    
    milestones = client.milestones("fresnel")
    milestone_input = scene.find("milestones")
    milestone_input.choices = milestones.collect{ |milestone| milestone.title }
  end
  
  def add_ticket
    title = scene.find("title")
    description = scene.find("description")
  
    client = LighthouseClient.new
    client.authenticate
    client.add_ticket({:title => title.text}, 21095)
    
    title.text = ""
    description.text = ""
  end

end