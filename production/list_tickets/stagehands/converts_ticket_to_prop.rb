gem 'limelight'
require 'limelight/prop'

class ConvertsTicketToProp
  def self.convert(ticket)
    puts "ticket.class.name: #{ticket.class.name}"
    wrapper = main_prop(ticket)
    [:title, :state, :formatted_age, :assigned_user_name].each do |attribute|
      wrapper.add(attribute_prop(ticket, attribute))
    end
    return wrapper
  end
  
  private
  
  def self.main_prop(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                               :players => "list_tickets",
                               :on_mouse_clicked => "view(#{ticket.id})")
  end
  
  def self.attribute_prop(ticket, attribute)
    return Limelight::Prop.new(:text => ticket.send(attribute), :name => "ticket_#{attribute}")
  end
end