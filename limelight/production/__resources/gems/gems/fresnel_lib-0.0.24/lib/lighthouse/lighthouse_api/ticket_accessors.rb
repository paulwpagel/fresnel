module TicketAccessors
  
  def self.included(klass)
    klass.extend(TicketAccessors)
  end
  
  def ticket_reader(method)
    define_method(method) do
      return @lighthouse_ticket.send(method)
    end
  end
  
  def ticket_writer(method)
    writer = "#{method}="
    define_method(writer) do |value|
      @lighthouse_ticket.send(writer, value)
    end
  end

  def ticket_accessor(method)
    ticket_reader(method)
    ticket_writer(method)
  end
end