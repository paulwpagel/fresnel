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
    new_row do |row|
      row.add(make_prop("Assigned User:", "assigned_user_header"))
      row.add(make_combo_box(current_ticket.assigned_user_name, "ticket_assigned_user"))
    end
    new_row do |row|
      row.add(make_prop("Milestone:", "milestone_header"))
      row.add(make_combo_box(milestone_title, "ticket_milestone"))
    end
    new_row { |row| row.add(make_prop(current_ticket.description, "ticket_description")) }
    current_ticket.fresnel_versions.each_with_index do |version, index|
      make_row_for_version(version, index)
    end
  end
  
  private ##################
  
  def make_row_for_version(version, index)
    new_row { |row| row.add(make_prop(version_content(version), "ticket_version_#{index + 1}"))}
  end
  
  def version_content(version)
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
  
  def make_combo_box(value, id)
    return Limelight::Prop.new(:choices => [value], :id => id, :name => "combo_box")
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