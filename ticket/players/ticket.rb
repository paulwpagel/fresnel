require "lighthouse_client"

module Ticket
  
  def scene_opened(e)
    unless $testing
      load_milestones 
      load_tickets
    end
  end  

  def button_pressed(e)
    add_ticket
  end

  def view(id)
    production.current_ticket = project.tickets.find{|ticket| ticket.id==id}
    scene.load('view_ticket')
  end
  
  def load_milestones
    milestone_input = scene.find("milestones")
    milestone_input.choices = milestone_choices
  end
  
  def load_tickets
    project.tickets.each do |ticket|  
      scene.children[0].add(prop_for(ticket))
    end
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

  private
  
  def project
    client = LighthouseClient.new
    return client.find_project("fresnel")
  end
  
  def milestone_choices
    client = LighthouseClient.new    
    milestones = client.milestones("fresnel")
    choices = ["None"]
    choices += milestones.collect{ |milestone| milestone.title }
  end
  
  def prop_for(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                                            :text => "#{ticket.title}, State: #{ticket.state}", :players => "ticket",
                                            :on_mouse_clicked => "view(#{ticket.id})")
  end
  
end