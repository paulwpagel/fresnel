require 'lighthouse_client'

module Main

  def add_ticket
    title = scene.find("title")
    description = scene.find("description")
    
    client = LighthouseClient.new
    
    client.add_ticket(title.text, 14953)
  end
  
end