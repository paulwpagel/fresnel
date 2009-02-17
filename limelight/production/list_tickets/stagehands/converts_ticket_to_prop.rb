
class ConvertsTicketToProp
  def self.convert(ticket)
    wrapper = main_prop(ticket)
    [:title, :state, :formatted_age, :assigned_user_name].each do |attribute|
      wrapper.add(attribute_prop(ticket, attribute))
    end
    wrapper.add(delete_prop(ticket))
    return wrapper
  end
  
  private #######################################
  
  def self.delete_prop(ticket)
    return Limelight::Prop.new(:id => "delete_ticket_#{ticket.id}", :name => "delete_ticket", :text => "delete")
  end
  
  def self.main_prop(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list", :players => "edit_ticket")
  end
  
  def self.attribute_prop(ticket, attribute)
    return Limelight::Prop.new(:text => ticket.send(attribute), :name => "ticket_#{attribute}", :width => "25%")
  end
end