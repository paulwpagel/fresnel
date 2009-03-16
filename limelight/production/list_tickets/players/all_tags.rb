module AllTags

  prop_reader :ticket_lister, :tag_lister

  def mouse_clicked(event)
    list_all_tags
  end
  
  def list_all_tags
    ticket_lister.clear_tag_filter
    tag_lister.show_project_tags    
  end

end