module Search
  def button_pressed(event)
    show_spinner do
      tickets = []
      criteria = scene.find("search_box").text

      scene.ticket_lister.last_tickets.each do |ticket|
        tickets << ticket if ticket.matches_criteria?(criteria)
      end
    
      scene.ticket_lister.show_these_tickets(tickets)
    end
  end
end