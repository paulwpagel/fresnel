module AllTags
  def mouse_clicked(event)
    scene.find("ticket_type").notify_ticket_master
  end
end