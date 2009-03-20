
module Website
  def button_pressed(event)
    show_spinner { show_url }
  end
  
  def show_url
    Browser.new.showInBrowser(url)
  end
  
  def url
    account = stage_info.client.account
    project_name = stage_info.current_project.hyphenated_name
    return "http://#{account}.lighthouseapp.com/projects/#{project_id}-#{project_name}/overview"
  end
  
  private #############
  
  def stage_info
    return production.stage_manager[scene.stage.name]
  end
  
  def project_id
    return stage_info.current_project.id
  end
  
end