require 'ticket_lister'
require 'ticket_master'

module ListTickets
  prop_reader :ticket_lister, :tag_lister, :age_image, :project_selector
    
  def ticket_master
    @ticket_master = TicketMaster.new(self) unless @ticket_master
    return @ticket_master
  end
  
  def scene_opened(event)
    show_spinner(scene.stage.name) {list}
  end
  
  def list
    project_selector.choices = all_project_names
    project_selector.value = starting_project_name
        
    age_image.style.background_image = "images/descending.png"
    
    tag_lister.show_project_tags
    ticket_lister.filter_by_type("Open Tickets")
  end
    
  private #######################
    
  def project
    return production.current_project
  end
  
  def all_project_names
    client = production.stage_manager[stage_name].client
    return client.project_names
  end
  
  def starting_project_name
    return all_project_names[0]
  end
  
  def stage_name
    return scene.stage.name
  end
end
