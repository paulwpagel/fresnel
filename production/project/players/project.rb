
module Project
  
  def scene_opened(event)
    main = scene.find_by_name('projects_display')[0]
    table = Limelight::Prop.new(:name => "table")
    production.lighthouse_client.projects.each do |project|
      table.add(Limelight::Prop.new(:name => "row", :id => project.name, :text => project.name, :players => "select_project"))
    end
    main.add(table)
  end
      
end