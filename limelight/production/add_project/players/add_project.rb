require 'lighthouse/lighthouse_api/project'

module AddProject
  
  def button_pressed(event)
    production.lighthouse_client.add_project(scene.find("project_name").text)
    scene.load("list_tickets")
  end
end