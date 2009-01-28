gem 'limelight'
require 'limelight/prop'

module CreateTicket
  def button_pressed(event)
    add_ticket_group = Limelight::Prop.new(:id => "add_ticket_group")
    scene.ticket_lister.add(add_ticket_group)
    build_prop add_ticket_group
  end
  
  private #############################
  
  def build_prop add_ticket_group
    add_ticket_group.build do

      input_group {
        label :text => "Title:"
        input :players => "text_box", :id => "add_ticket_title", :width => 200
      }
      input_group {
        label :text => "Description:"
        input :players => "text_box", :id => "add_ticket_description", :width => 200
      }
      
      input_group{
        label :text => "Milestone:"
        combo_box :id => 'add_ticket_milestone'
      }
    end
    scene.find("add_ticket_milestone").choices = ["None"] + production.current_project.milestone_titles
  end
end