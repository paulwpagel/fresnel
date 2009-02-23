require 'lighthouse/lighthouse_api/project'

module AddProject
  
  def button_pressed(event)
    add_project_options = {
      :name => scene.find("project_name").text,
      :public => scene.find("public").text
      }
    production.lighthouse_client.add_project(add_project_options)
    scene.load("list_tickets")
  end
end