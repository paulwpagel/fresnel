module ProjectSelector  
  def value_changed(event)
    show_spinner do
      production.current_project = production.lighthouse_client.find_project(project_name)
      scene.ticket_lister.show_these_tickets(production.current_project.open_tickets)
      scene.tag_lister.show_project_tags
      update_credentials
    end
  end
  
  private ############################
  
  def update_credentials
    if Credential.save_credentials?
      Credential.project_name = project_name
      Credential.save
    end
  end
  
  def project_name
    return text
  end
end