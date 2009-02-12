require File.expand_path(File.dirname(__FILE__) + "/../stagehands/converts_ticket_to_prop")

module TicketLister
  attr_reader :last_tickets

  def show_these_tickets(tickets)
    @last_tickets = tickets
    remove_all
    mapped_tickets = tickets.map {|ticket| ConvertsTicketToProp.convert(ticket) }
    mapped_tickets.each { |prop| self.add(prop) }
  end

end