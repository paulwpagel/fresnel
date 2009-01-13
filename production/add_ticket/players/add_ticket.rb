module AddTicket
  
  def scene_opened(e)
    load_milestones
    load_users
  end
  
  def button_pressed(e)
    add_ticket
  end
  
  def load_milestones
    milestone_input = scene.find("milestones")
    milestone_input.choices = milestone_choices
  end
  
  def load_users #TODO - PWP - should have default user of none responsible
    users = production.lighthouse_client.users_for_project(production.current_project)
    responsible_person = scene.find("responsible_person")
    users.collect! {|user| user.name} #TODO - PWP - use the model to do this
    responsible_person.choices = users
  end  
  
  def add_ticket
    title = scene.find("title")
    description = scene.find("description")
    responsible_person = scene.find("responsible_person")
    
    assigned_user_id = production.current_project.user_id(responsible_person.text)
        
    ticket_options = {}
    ticket_options[:title] = title.text 
    ticket_options[:description] = description.text
    ticket_options[:assigned_user_id] = assigned_user_id

    production.lighthouse_client.add_ticket(ticket_options, production.current_project)
    
    scene.load("list_tickets")
  end
    
  private #############
  
  def project_id
    production.current_project.id
  end
  
  def milestone_choices
    choices = ["None"]
    choices += production.current_project.milestones.collect{ |milestone| milestone.title }
  end
    
end