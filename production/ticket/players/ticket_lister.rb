require File.expand_path(File.dirname(__FILE__) + "/../stagehands/converts_ticket_to_prop")

module TicketLister
  def show_these_tickets(tickets)
    self.remove_all
    tickets.map { |ticket| 
      ConvertsTicketToProp.convert(ticket)
    }.each { |prop|
      self.add(prop)
    }
  end
end