require 'lighthouse/lighthouse_api/project'

module AddProject
  prop_reader :public, :error_message, :project_name
  
  def button_pressed(event)
    add_project
  end
  
  def add_project
    project_name_text = project_name.text
    if project_name_text.empty?
      error_message.text = "Please enter a project name"
    else
      add_project_options = {
        :name => project_name_text,
        :public => public.text
        }
      production.lighthouse_client.add_project(add_project_options)
      scene.load("list_tickets")
    end
    
  end
end