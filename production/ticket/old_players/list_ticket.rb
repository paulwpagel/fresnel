require 'lighthouse_client'

module ListTicket
  def value_changed(event)
    unless $testing
      update_ticket_list
    end
  end
  
  def update_ticket_list
    desired_tickets = value
    
    client = LighthouseClient.new
    project = client.find_project('fresnel')
    if desired_tickets == 'Open Tickets'
      project.open_tickets
    else
      project.all_tickets
    end
  end
end
