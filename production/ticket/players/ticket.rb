require "lighthouse_client"
require "lighthouse/project"

require 'ticket_lister'

module Ticket
  
  class << self
    def stage_hand(name)
      require name.to_s
      define_method(name) do
        eval(name.to_s.camelize).new(self)
      end
    end
  end
  
  stage_hand :ticket_master  
  prop_reader :ticket_lister
  
  def view(id)
    production.current_ticket = LighthouseClient.new.ticket(id)#project.all_tickets.find{|ticket| ticket.id==id}
    scene.load('view_ticket')
  end
  
  private #######################
  
  def project
    client = LighthouseClient.new
    return client.find_project("fresnel")
  end
  
end