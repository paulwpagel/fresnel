
class TicketMaster
  def initialize(scene)
    @scene = scene
  end
  
  def show_tickets(type)
    project = @scene.production.lighthouse_client.find_project('fresnel')
    if type == "Open Tickets"
      tickets = project.open_tickets
    else
      tickets = project.all_tickets
    end
    @scene.ticket_lister.show_these_tickets(tickets)
  end
end