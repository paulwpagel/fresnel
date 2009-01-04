module SelectProject
  
  def mouse_clicked(event)
    project = production.lighthouse_client.find_project(self.id)
    production.current_project = project
    scene.load("list_tickets")
  end
end