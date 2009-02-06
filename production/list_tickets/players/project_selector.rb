module ProjectSelector
  
  def value_changed(event)
    production.current_project = production.lighthouse_client.find_project(text)
    scene.ticket_lister.show_these_tickets(production.current_project.open_tickets)
    scene.tag_lister.show_project_tags
  end
end