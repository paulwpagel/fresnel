gem 'limelight'
require 'limelight/prop'

class ConvertsTicketToProp
  def self.convert(ticket)
    Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                        :text => "#{ticket.title}, State: #{ticket.state}", :players => "list_tickets",
                        :on_mouse_clicked => "view(#{ticket.id})")
  end
end