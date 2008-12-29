module ViewTicket
  
  def scene_opened(event)
    load_current_ticket
  end
  
  def load_current_ticket
    new_row do |row|
      row.add(make_prop(current_ticket.title, "ticket_title"))
      row.add(make_prop(current_ticket.state.capitalize, "ticket_state"))
    end
    new_row do |row|
      row.add(make_prop("Assigned User:", "assigned_user_header"))
      row.add(make_combo_box([current_ticket.assigned_user_name], "ticket_assigned_user", current_ticket.assigned_user_name))
    end
    new_row do |row|
      row.add(make_prop("Milestone:", "milestone_header"))
      row.add(make_combo_box(all_milestone_titles, "ticket_milestone", milestone_title))
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
  
  def make_combo_box(choices, id, value)
    return Limelight::Prop.new(:choices => choices, :id => id, :name => "combo_box", :value => value)
  end

  def make_prop(text, name)
    return Limelight::Prop.new(:text => text, :name => name, :id => name)
  end
    
  def main
    return scene.find_by_name('main')[0]
  end
  
  def all_milestone_titles
    return production.lighthouse_client.find_project('fresnel').milestone_titles
  end
  
  def milestone_title
    return production.lighthouse_client.milestone_title('fresnel', current_ticket.milestone_id)
  end
end