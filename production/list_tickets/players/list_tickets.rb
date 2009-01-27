require 'ticket_lister'
require 'ticket_master'

module ListTickets
  
  prop_reader :ticket_lister
  
  def ticket_master
    TicketMaster.new(self)
  end
  
  def scene_opened(event)
    production.current_project = production.lighthouse_client.find_project(production.lighthouse_client.projects[0].name) unless  production.current_project #TODO - PWP - It should save the last project you were on 

    ticket_master.show_tickets("Open Tickets")
    scene.find("age_image").style.background_image = "images/descending.png"
    scene.find("project_selector").choices = project_names
  end
  
  def view(ticket_id)
    production.current_ticket = production.lighthouse_client.ticket(ticket_id, project)
    scene.load('view_ticket')
  end
  
  private #######################
    
  def project
    production.current_project
  end

  #TODO - move this method into model
  def project_names
    return production.lighthouse_client.projects.collect {|project| project.name}
  end
end