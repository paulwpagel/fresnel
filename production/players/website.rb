import "src.Browser"

module Website
  def button_pressed(event)
    Browser.new.showInBrowser(url)
  end
  
  def url
    return "http://#{account}.lighthouseapp.com"
  end
  
  private
  
  def account
    return production.lighthouse_client.account
  end
end