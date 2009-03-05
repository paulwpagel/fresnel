module AllTags
  def mouse_clicked(event)
    scene.ticket_master.clear_tag_filter
    scene.tag_lister.show_project_tags
  end
end