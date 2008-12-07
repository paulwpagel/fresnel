require 'lighthouse_client'

module Main

  def add_ticket
    title = scene.find("title")
    description = scene.find("description")
    
    client = LighthouseClient.new
    client.authenticate
    client.add_ticket(title.text, 21095)
  end
  
end