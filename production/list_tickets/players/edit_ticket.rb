module EditTicket

  def mouse_clicked(event)
    if(scene.find("save_button").nil?)
      production.current_ticket = production.lighthouse_client.ticket(ticket_id, production.current_project)
      remove_all
      build_edit_ticket
    end
  end
  
  private ###################
  
  def build_edit_ticket
    build(:ticket => production.current_ticket, :project => production.current_project) do
      row {
        button :text => "Save Ticket", :id => "save_button", :players => "save_ticket"
      }
      row {
        cell {
          text_box :id => "ticket_title", :width => 250, :text => @ticket.title
        }
        cell {
          combo_box :id => "ticket_state", :choices => @project.all_states, :value => @ticket.state
        }
      }
      row {
        label :text => "Tags:"
        text_box :id => "ticket_tag", :width => 350, :text => @ticket.tag
      }
      row {
        milestone_header :text => "Milestone:"
        combo_box :id => "ticket_milestone", :choices => [""] + @project.milestone_titles, :value => @project.milestone_title(@ticket.milestone_id)
      }
      row{
        comment_header :text => "Add Comment:"
        text_area :id => "ticket_comment", :name => "ticket_comment"
      }
      
      #TODO - EWM - push some of the logic back onto the model      
      @ticket.versions.each_with_index do |version, index|
        row {
          change_message = ""
          @ticket.changed_attributes_for_version(index).each do |attribute|
            change_message << "#{attribute.name} changed from \"#{attribute.old_value}\" to \"#{attribute.new_value}\"\n"
          end
          text =  "#{version.created_by}\n#{version.timestamp}\n#{change_message}\n#{version.comment}"
          label :name => "ticket_version_#{index + 1}", :id => "ticket_version_#{index + 1}", :text => text
        }

      end

      row {
        assigned_user_header :text => "Assigned User:"
        combo_box :id => "ticket_assigned_user", :choices => [""] + @project.user_names, :value => @ticket.assigned_user_name
      }
      row {
        description_header :text => "Description:"
        ticket_description :id => "ticket_description", :text => @ticket.description
      }      
    end
  end
  
  def ticket_id
    return id.split("_")[1].to_i
  end
end