
module Website
  def button_pressed(event)
    show_spinner { show_url }
  end
  
  def show_url
    Browser.new.showInBrowser(url)
  end
  
  def url
    account = production.lighthouse_client.account
    project_name = production.current_project.hyphenated_name
    return "http://#{account}.lighthouseapp.com/projects/#{project_id}-#{project_name}/overview"
  end
  
  private #############
    
  def project_id
    return production.current_project.id
  end
  
end