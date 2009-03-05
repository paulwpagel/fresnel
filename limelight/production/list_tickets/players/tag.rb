module Tag  
  def mouse_clicked(event)
    show_spinner do
      scene.ticket_lister.filter_by_tag(self.text)
      scene.tag_lister.activate(self.id)
    end
  end
end