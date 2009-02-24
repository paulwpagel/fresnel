module Tag  
  def mouse_clicked(event)
    show_spinner do
      scene.ticket_lister.show_these_tickets(tickets)
    end
  end
  
  private ##################
  
  def tickets
    production.current_project.tickets_for_tag(self.text)
  end
end