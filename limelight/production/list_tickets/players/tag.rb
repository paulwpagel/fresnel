module Tag  
  prop_reader :ticket_lister, :tag_lister
  def mouse_clicked(event)

    show_spinner { tag}

  end
  
  def tag
    ticket_lister.filter_by_tag(self.text)
    tag_lister.activate(self.id)
  end
end