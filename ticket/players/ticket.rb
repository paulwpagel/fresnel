require 'lighthouse_client'

module Ticket
  
  def button_pressed(e)
    add_ticket
  end

  def add_ticket
    title = scene.find("title")
    description = scene.find("description")
  
    client = LighthouseClient.new
    client.authenticate
    client.add_ticket({:title => title.text}, 21095)
  end
  
end