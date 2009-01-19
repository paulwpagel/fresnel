gem 'limelight'
require 'limelight/prop'

class ConvertsTicketToProp
  def self.convert(ticket)
    wrapper = main_prop(ticket)
    wrapper.add(title_prop(ticket))
    wrapper.add(state_prop(ticket))
    return wrapper
  end
  
  private
  
  def self.main_prop(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                               :players => "list_tickets",
                               :on_mouse_clicked => "view(#{ticket.id})")
  end
  
  def self.title_prop(ticket)
    return Limelight::Prop.new(:text => ticket.title, :name => "ticket_title")
  end
  
  def self.state_prop(ticket)
    return Limelight::Prop.new(:text => ticket.state, :name => "ticket_state")
  end
end