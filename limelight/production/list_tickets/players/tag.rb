module Tag  
  def mouse_clicked(event)
    scene.ticket_lister.show_these_tickets(tickets)
  end
  
  private ##################
  
  def tickets
    production.current_project.tickets_for_tag(self.text)
  end
end