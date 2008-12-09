require "lighthouse_client"

module Ticket

  def scene_opened(e)
    load_milestones
    load_tickets
  end  

  def button_pressed(e)
    add_ticket
  end

  def view(id)
    puts "here: #{id}"
  end
  
  def load_milestones
    milestone_input = scene.find("milestones")
    milestone_input.choices = milestone_choices
  end
  
  def load_tickets
    client = LighthouseClient.new
    tickets = client.find_project("fresnel").tickets
    tickets.each do |ticket|  
      prop = Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                                              :text => "#{ticket.title}, State: #{ticket.state}", :players => "ticket",
                                              :on_mouse_clicked => "view(#{ticket.id})")
      scene.children[0].add(prop)
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
  
  def milestone_choices
    client = LighthouseClient.new    
    milestones = client.milestones("fresnel")
    choices = ["None"]
    choices += milestones.collect{ |milestone| milestone.title }
  end
  
end