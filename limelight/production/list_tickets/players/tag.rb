module Tag  
  def mouse_clicked(event)
    show_spinner do
      scene.ticket_master.filter_by_tag(self.text)
    end
  end
end