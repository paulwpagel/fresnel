module ViewTicket
  
  def scene_opened(event)
    load_current_ticket
  end
  
  def load_current_ticket
    scene.find("ticket_title").text = current_ticket.title
    scene.find("ticket_state").choices = ["new", "open", "resolved", "hold", "invalid"]
    scene.find("ticket_state").value = current_ticket.state
    new_row do |row|
      row.add(make_prop("Assigned User:", "assigned_user_header"))
      row.add(make_combo_box([current_ticket.assigned_user_name], "ticket_assigned_user", current_ticket.assigned_user_name))
    end
    new_row do |row|
      row.add(make_prop("Milestone:", "milestone_header"))
      row.add(make_combo_box(milestone_choices, "ticket_milestone", milestone_title))
    end
    new_row { |row| row.add(make_prop(current_ticket.description, "ticket_description")) }
    current_ticket.versions.each_with_index do |version, index|
      make_row_for_version(version, index)
    end
    new_row do |row|
      row.add(make_prop("Add Comment:", "comment_header"))
      row.add(Limelight::Prop.new(:name => "text_box", :id => "ticket_comment"))
    end
  end
  
  private ##################
  
  def make_row_for_version(version, index)
    new_row do |row|
      version_cell = Limelight::Prop.new(:name => "version_cell")
      row.add(version_cell)
      version_cell.add(make_prop(version_content(version, index), "ticket_version_#{index + 1}"))
    end
  end
  
  def version_content(version, index)
    changed_attributes = current_ticket.changed_attributes_for_version(index)
    change_message = ""
    changed_attributes.each do |attribute|
      change_message << "#{attribute.name} changed from \"#{attribute.old_value}\" to \"#{attribute.new_value}\"\n"
    end
    return "#{version.created_by}\n#{version.timestamp}\n#{change_message}\n#{version.comment}"
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
  
  def milestone_choices
    return [""] + all_milestone_titles
  end
  
  def all_milestone_titles
    return production.lighthouse_client.find_project('fresnel').milestone_titles
  end
  
  def milestone_title
    return production.lighthouse_client.milestone_title('fresnel', current_ticket.milestone_id)
  end
end