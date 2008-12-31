require 'ticket_lister'

module ListTickets
  
  class << self
    def stage_hand(name)
      require name.to_s
      define_method(name) do
        return TicketMaster.new(self)
        # eval(name.to_s.camelize).new(self)
      end
    end
  end
    
  stage_hand :ticket_master  
  prop_reader :ticket_lister
  
  def view(id)
    production.current_ticket = production.lighthouse_client.ticket(id)
    scene.load('view_ticket')
  end
  
  private #######################
  
  def project
    return production.lighthouse_client.find_project("fresnel")
  end
  
end