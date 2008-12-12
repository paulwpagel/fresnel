require "lighthouse_client"
require "lighthouse/project"

module Ticket
  
  def scene_opened(e)
  end  

  def view(id)
    production.current_ticket = project.open_tickets.find{|ticket| ticket.id==id}
    scene.load('view_ticket')
  end
  
  private #######################
  
  def project
    client = LighthouseClient.new
    return client.find_project("fresnel")
  end
  
end