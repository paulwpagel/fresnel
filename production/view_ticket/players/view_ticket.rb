require "lighthouse/ticket"

module ViewTicket
  
  def scene_opened(event)
    load_current_ticket
  end
  
  def load_current_ticket
    # TODO - EWM - I want to do it this way, but a bug in limelight with screen refreshing (Ticket #89) is preventing me from doing so
    # scene.find("ticket_title").text = current_ticket.title
    # scene.find("ticket_state").text = current_ticket.state.capitalize
    # scene.find("ticket_assigned_user").text = "Assigned User: #{current_ticket.assigned_user_name}"
    # scene.find("ticket_milestone").text = milestone_title
    new_row do |row|
      row.add(make_prop(current_ticket.title, "ticket_title"))
      row.add(make_prop(current_ticket.state.capitalize, "ticket_state"))
    end
    new_row { |row| row.add(make_prop("Assigned User: #{current_ticket.assigned_user_name}", "ticket_assigned_user")) }
    new_row { |row| row.add(make_prop(milestone_title, "ticket_milestone")) }
    new_row { |row| row.add(make_prop(current_ticket.description, "ticket_description")) }
    new_row { |row| row.add(make_prop(version_content, "ticket_version_1"))}
  end
  
  private ##################
  
  def version_content
    version = current_ticket.fresnel_versions[0]
    return "#{version.created_by}\n#{version.timestamp}\n#{version.comment}"
  end
  
  def new_row
    row = Limelight::Prop.new(:name => "row")
    yield row
    main.add(row)
  end
  
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
    return production.lighthouse_client.milestone_title('fresnel', current_ticket.milestone_id)
  end
end