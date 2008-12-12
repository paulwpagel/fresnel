require File.expand_path(File.dirname(__FILE__) + "/../helpers/converts_ticket_to_prop")

module TicketLister
  def show_these_tickets(tickets)
    container = scene.find('ticket_list_container')
    tickets.map { |ticket| 
      ConvertsTicketToProp.convert(ticket)
    }.each { |prop|
      container.add(prop)
    }
  end
end