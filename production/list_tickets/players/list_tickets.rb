require 'ticket_lister'
require 'ticket_master'

module ListTickets
  prop_reader :ticket_lister
  prop_reader :tag_lister
  
  def ticket_master
    TicketMaster.new(self)
  end
  
  def scene_opened(event)
    project_name = production.lighthouse_client.get_starting_project_name
    scene.find("project_selector").choices = production.lighthouse_client.project_names
    scene.find("project_selector").value = project_name
    
    #TODO - EWM - should ticket_lister know the default tickets?
    ticket_master.show_tickets("Open Tickets")
    scene.find("age_image").style.background_image = "images/descending.png"
    scene.tag_lister.show_project_tags
  end
  
  def view(ticket_id)
    production.current_ticket = production.lighthouse_client.ticket(ticket_id, project)
    scene.load('view_ticket')
  end
  
  private #######################
    
  def project
    production.current_project
  end

end