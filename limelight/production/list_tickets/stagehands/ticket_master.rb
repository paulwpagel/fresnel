class TicketMaster

  def initialize(scene)
    @scene = scene
  end
  
  def tickets_for_type_and_tag(type, tag)
    return tickets_for_type(type) if tag.nil?
    return project.tickets_for_tag(tag) if type.nil?
    return project.tickets_for_tag(tag) & tickets_for_type(type)
  end
  
  def filter_by_type_and_tag
    tickets = project.tickets_for_tag(@current_tag_filter) & tickets_for_type(@current_type_filter)
    @scene.ticket_lister.show_these_tickets(tickets) if @scene.ticket_lister
  end

  #TODO - EWM pull this method out
  def tickets_for_type(type)
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