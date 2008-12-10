require "lighthouse_client"

module Ticket
  
  def scene_opened(e)
    unless $testing
      load_tickets
    end
  end  
    
  def load_tickets
    project.tickets.each do |ticket|  
      scene.children[0].add(prop_for(ticket))
    end
  end

  def view(id)
    production.current_ticket = project.tickets.find{|ticket| ticket.id==id}
    scene.load('view_ticket')
  end
  
  private #######################
  
  def project
    client = LighthouseClient.new
    return client.find_project("fresnel")
  end
    
  def prop_for(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                                            :text => "#{ticket.title}, State: #{ticket.state}", :players => "ticket",
                                            :on_mouse_clicked => "view(#{ticket.id})")
  end
  
end