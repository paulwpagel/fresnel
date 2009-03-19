module Search
  prop_reader :search_box, :ticket_lister

  def button_pressed(event)
    show_spinner(scene.stage.name) {search}
  end
  
  def search
    ticket_lister.search_on(search_box.text)
  end
  
end