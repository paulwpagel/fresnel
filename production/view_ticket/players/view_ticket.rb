require "lighthouse/ticket"

module ViewTicket
  
  def scene_opened(event)
    unless $testing
      load_current_ticket
    end
  end
  
  def load_current_ticket
    group_one = Limelight::Prop.new(:name => "group")
    group_one.add(make_prop(current_ticket.title, "ticket_title"))
    group_one.add(make_prop(current_ticket.state.capitalize, "ticket_state"))

    group_two = Limelight::Prop.new(:name => "group")
    group_two.add(make_prop("Assigned User: #{current_ticket.assigned_user_name}", "ticket_assigned_user"))

    group_three = Limelight::Prop.new(:name => "group")
    group_three.add(make_prop(milestone_title, "ticket_milestone"))
    
    main.add(group_one)
    main.add(group_two)
    main.add(group_three)
  end
  
  private
  
  def current_ticket
    return production.current_ticket
  end
  
  def make_prop(text, name)
    return Limelight::Prop.new(:text => text, :name => name, :id => name)
  end
  
  def main
    return scene.find_by_name('main')[0]
  end
  
  def milestone_title
    return LighthouseClient.new.milestone_title('fresnel', current_ticket.milestone_id)
  end
end