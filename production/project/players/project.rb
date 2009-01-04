
module Project
  
  def scene_opened(event)
    main = scene.find_by_name('main')[0]
    projects = production.lighthouse_client.projects.each do |project|
      main.add(Limelight::Prop.new(:name => "row", :id => project.name, :text => project.name, :players => "select_project"))
    end
  end
      
end