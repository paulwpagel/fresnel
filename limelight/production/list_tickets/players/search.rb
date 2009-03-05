module Search
  def button_pressed(event)
    show_spinner do
      scene.ticket_lister.search_on(search_criteria)
    end
  end
  
  private ####################
  
  def search_criteria
    return scene.find("search_box").text
  end
end