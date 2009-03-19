require "credential"

module ProjectSelector  
  prop_reader :ticket_lister, :tag_lister
  
  def value_changed(event)
    show_spinner { select_project }
  end
  
  def select_project
    production.stage_manager.notify_of_project_change(text, stage_name)
    ticket_lister.show_these_tickets(open_tickets(stage_name))
    tag_lister.show_project_tags
  end
  
  private ###########################
  
  def stage_name
    return scene.stage.name
  end
  
  def open_tickets(stage_name)
    return production.stage_manager[stage_name].current_project.open_tickets
  end
end