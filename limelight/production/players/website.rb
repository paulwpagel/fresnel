
module Website
  def button_pressed(event)
    show_spinner { show_url }
  end
  
  def show_url
    Browser.new.showInBrowser(url)
  end
  
  def url
    #account and project_name are prop_readers
    account = production.stage_manager.client_for_stage(scene.stage.name).account
    project_name = current_project.hyphenated_name
    return "http://#{account}.lighthouseapp.com/projects/#{project_id}-#{project_name}/overview"
  end
  
  private #############
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
  
  def project_id
    return current_project.id
  end

end