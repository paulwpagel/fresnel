
class ConvertsTicketToProp
  def self.convert(ticket)
    wrapper = main_prop(ticket)
    wrapper.add(delete_prop(ticket))
    title = ticket.title

    if title.size > 25
      title = "#{title[0..24]}..."
    end
    wrapper.add(Limelight::Prop.new(:text => title, :name => "ticket_title", :width => "25%"))
    [:state, :formatted_age, :assigned_user_name].each do |attribute|
      wrapper.add(attribute_prop(ticket, attribute))
    end
    return wrapper
  end
  
  private #######################################
  
  def self.delete_prop(ticket)
    return Limelight::Prop.new(:id => "delete_ticket_#{ticket.id}", :name => "delete_ticket")
  end
  
  def self.main_prop(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list", :players => "edit_ticket")
  end
  
  def self.attribute_prop(ticket, attribute)
    return Limelight::Prop.new(:text => ticket.send(attribute), :name => "ticket_#{attribute}", :width => "25%")
  end
end