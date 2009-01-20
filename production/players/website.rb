import "src.Browser"

module Website
  def button_pressed(event)
    Browser.new.showInBrowser("http://lighthouseapp.com")
  end
end