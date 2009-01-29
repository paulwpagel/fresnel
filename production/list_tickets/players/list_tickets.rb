require 'ticket_lister'

module ListTickets
  
  class << self
    def stage_hand(name)
      require name.to_s
      define_method(name) do
        return TicketMaster.new(self) #TODO - PWP - solve why this needs to be instantiated rather than the eval working
        # eval(name.to_s.camelize).new(self)
      end
    end
  end
    
  stage_hand :ticket_master  
  prop_reader :ticket_lister
  
  def scene_opened(event)
    ticket_master.show_tickets("Open Tickets")
    scene.find("age_image").style.background_image = "images/descending.png"
    populate_tags
  end
  
  def view(ticket_id)
    production.current_ticket = production.lighthouse_client.ticket(ticket_id, project)
    scene.load('view_ticket')
  end
  
  private #######################
  
  def populate_tags
    tags = scene.find("tags")
    project.tag_names.each_with_index do |tag, index|
      tags.add(Limelight::Prop.new(:name => "tag", :text => tag, :id => "tag_#{index + 1}"))
    end
  end
  
  def project
    production.current_project
  end
end