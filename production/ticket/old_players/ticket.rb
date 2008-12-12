require "lighthouse_client"
require "lighthouse/project"
require File.expand_path(File.dirname(__FILE__) + "/ticket_master")

module Ticket
  include TicketMaster
  
  def scene_opened(e)
    unless $testing
      load_tickets
    end
  end  
    
  def load_tickets
    show_tickets(project.open_tickets)
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