require "credential"

module ProjectSelector  
  prop_reader :ticket_lister, :tag_lister
  
  def value_changed(event)
    show_spinner { select_project }
  end
  
  def select_project
    production.current_project = production.lighthouse_client.find_project(text)
    ticket_lister.show_these_tickets(production.current_project.open_tickets)
    tag_lister.show_project_tags
    update_credentials
  end
  
  private ############################
  
  def update_credentials
    if Credential.save_credentials?
      Credential.project_name = text
      Credential.save
    end
  end
  
end