class TicketMaster

  def initialize(scene)
    @scene = scene
  end
  
  def filter_by_type(type)    
    @scene.ticket_lister.show_these_tickets(get_tickets(type)) if @scene.ticket_lister
  end
  
  def filter_by_tag(tag)
    @scene.ticket_lister.show_these_tickets(project.tickets_for_tag(tag)) if @scene.ticket_lister
  end
  
  def get_tickets(type)
    if type == "Open Tickets"
      return project.open_tickets
    else
      return project.all_tickets
    end
  end
  
  def project
    return @scene.production.current_project
  end
  
end