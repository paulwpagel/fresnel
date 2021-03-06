require 'ticket_lister'
require 'ticket_master'

module ListTickets
  prop_reader :ticket_lister, :tag_lister, :age_image, :project_selector, :milestone_lister
    
  def ticket_master
    @ticket_master = TicketMaster.new(self) unless @ticket_master
    return @ticket_master
  end
  
  def scene_opened(event)
    show_spinner {list}
  end
  
  def loading?
    return @loading
  end
  
  def list
    @loading = true
    
    cached_all_project_names = all_project_names
    
    cached_project_name = stage_info.current_project_name
    project_selector.choices = cached_all_project_names
    
    if cached_project_name
      project_selector.value = cached_project_name
    else
      production.stage_manager.notify_of_project_change(cached_all_project_names[0], scene.stage.name)
      project_selector.value = cached_all_project_names[0]
    end
    @loading = false

    age_image.style.background_image = "images/descending.png"
    
    tag_lister.show_project_tags
    ticket_lister.filter_by_type("Open Tickets")
    stage_info.current_project.register_milestone_observer(milestone_lister)
    
    milestone_lister.list_titles
  end
    
  private #######################
  
  def all_project_names
    client = production.stage_manager.client_for_stage(scene.stage.name)
    return client.project_names
  end
  
  def stage_info
    return production.stage_manager[scene.stage.name]
  end
  
end
