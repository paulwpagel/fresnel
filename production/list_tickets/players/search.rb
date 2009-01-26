

module Search
  
  def button_pressed(event)
    tickets = []
    criteria = scene.find("search_box").text

    production.current_project.all_tickets.each do |ticket|
      tickets << ticket if ticket.matches_criteria?(criteria)
    end
    
    scene.ticket_lister.show_these_tickets(tickets)
  end
end