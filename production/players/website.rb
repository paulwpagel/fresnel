import "src.Browser"

module Website
  def mouse_clicked(event)
    Browser.new.showInBrowser("http://lighthouseapp.com")
  end
end