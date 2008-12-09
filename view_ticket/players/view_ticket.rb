require "lighthouse/ticket"

module ViewTicket
  
  def scene_opened(event)
    unless $testing
      load_current_ticket
    end
  end
  
  def load_current_ticket
    add_prop_to_main(current_ticket.title, "ticket_title")
    add_prop_to_main(current_ticket.assigned_user_name, "ticket_assigned_user")
  end
  
  private
  
  def current_ticket
    return production.current_ticket
  end
  
  def add_prop_to_main(text, name)
    prop = Limelight::Prop.new(:text => text, :name => name)
    main.add(prop)
  end
  
  def main
    return scene.find_by_name('main')[0]
  end
end