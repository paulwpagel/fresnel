require 'ticket_lister'
require 'ticket_master'

module ListTickets
  prop_reader :ticket_lister
  prop_reader :tag_lister
    
  def ticket_master
    TicketMaster.new(self)
  end
  
  def scene_opened(event)
    show_spinner do
      # TODO - EWM fix how we are testing this method
      # This order is important.  Setting the choices on the project selector will update the project name in the credentials
      # This will cause the first project to be loaded as the default project regardless of what was saved before
      project_name = production.lighthouse_client.get_starting_project_name
      scene.find("project_selector").choices = production.lighthouse_client.project_names
      scene.find("project_selector").value = project_name

      #TODO - EWM - should ticket_lister know the default tickets?
      ticket_master.show_tickets("Open Tickets")
      scene.find("age_image").style.background_image = "images/descending.png"
      scene.tag_lister.show_project_tags
    end
  end
    
  private #######################
  
  def show_spinner(&block)
    spinner = Limelight::Prop.new(:name => "spinner", :id => "spinner")
    spinner.add(Limelight::Prop.new(:name => "spinner_message", :text => "Loading..."))
    scene.add(spinner) unless scene.find("spinner")
    yield
    scene.remove(scene.find("spinner"))
  end
  
  def project
    production.current_project
  end

end
