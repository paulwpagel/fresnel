class TicketMaster
  def initialize(scene)
    @scene = scene
  end
  
  def show_tickets(type)    
    @scene.ticket_lister.show_these_tickets(get_tickets(type))
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