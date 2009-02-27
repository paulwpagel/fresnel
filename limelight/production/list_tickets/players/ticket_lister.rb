require File.expand_path(File.dirname(__FILE__) + "/../stagehands/converts_ticket_to_prop")

module TicketLister
  attr_reader :last_tickets

  def show_these_tickets(tickets)
    @last_tickets = tickets
    remove_all
    mapped_tickets = tickets.map {|ticket| ConvertsTicketToProp.convert(ticket) }
    mapped_tickets.each { |prop| self.add(prop) }
  end
  
  def remove_ticket(ticket_id)
    children.each do |ticket_row|
      remove(ticket_row) if ticket_row.id == "ticket_#{ticket_id}"
    end
  end
  
  def cancel_edit_ticket
    ticket_prop = scene.find("ticket_#{production.current_ticket.id}")
    ticket_prop.remove_all
    new_ticket_prop = ConvertsTicketToProp.convert(production.current_ticket)
    new_ticket_prop.children.each do |child|
      ticket_prop.add(child)
    end
    production.current_ticket = nil
  end
end