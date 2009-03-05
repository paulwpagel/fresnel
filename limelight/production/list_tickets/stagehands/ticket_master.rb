class TicketMaster

  def initialize(scene)
    @scene = scene
  end
  
  def filter_by_type(type)
    @current_type_filter = type
    if @current_tag_filter
      filter_by_type_and_tag
    else
      @scene.ticket_lister.show_these_tickets(tickets_for_type(type)) if @scene.ticket_lister
    end
  end
  # 
  # def filter_by_tag(tag)
  #   @current_tag_filter = tag
  #   filter_by_type_and_tag
  # end

  def tickets_for_type_and_tag(type, tag)
    return tickets_for_type(type) unless tag
    return project.tickets_for_tag(tag)
  end
  
  def filter_by_type_and_tag
    tickets = project.tickets_for_tag(@current_tag_filter) & tickets_for_type(@current_type_filter)
    @scene.ticket_lister.show_these_tickets(tickets) if @scene.ticket_lister
  end
  
  def clear_tag_filter
    @current_tag_filter = nil
    filter_by_type(@current_type_filter)
  end
  
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