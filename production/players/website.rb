import "src.Browser"

module Website
  def button_pressed(event)
    Browser.new.showInBrowser(url)
  end
  
  def url
    return "http://#{account}.lighthouseapp.com/projects/#{project_id}-#{project_name}/overview"
  end
  
  private
  
  def account
    return production.lighthouse_client.account
  end
  
  def project_id
    return production.current_project.id
  end
  
  def project_name
    return production.current_project.hyphenated_name
  end
end