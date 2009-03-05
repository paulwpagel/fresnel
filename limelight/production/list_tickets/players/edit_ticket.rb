module EditTicket
  def mouse_clicked(event)
    if(scene.find("save_button").nil?)
      show_spinner do
        production.current_ticket = production.lighthouse_client.ticket(ticket_id, production.current_project)
        remove_all
        build_edit_ticket
        hover_style.background_color = "5A9ECF"
      end
    end
  end
  
  private ###################
  
  def build_edit_ticket
    build(:ticket => production.current_ticket, :project => production.current_project) do
      main_ticket_group {
        row {
          cell {
            edit_ticket_label :text => "Title:"
          }
          cell {
            text_box :id => "ticket_title", :width => 350, :text => @ticket.title
          }
          cell {
            edit_ticket_label :text => "State:"
          }
          cell {
            combo_box :id => "ticket_state", :choices => @project.all_states, :value => @ticket.state
          }
        }
        row {
          cell(:width => "30%") {
            edit_ticket_label :text => "Description:"
          }
          cell {
            ticket_description :id => "ticket_description", :text => @ticket.description, :styles => "edit_ticket_label"
          }
        }
        row {
          cell(:width => "30%") {
            edit_ticket_label :text => "Assigned User:"
          }
          cell {
            combo_box :id => "ticket_assigned_user", :choices => [""] + @project.user_names, :value => @ticket.assigned_user_name, :width => "50%"
          }
        }
        row {
          cell(:width => "30%") {
            edit_ticket_label :text => "Milestone:"
          }
          cell {
            combo_box :id => "ticket_milestone", :choices => [""] + @project.milestone_titles, :value => @project.milestone_title(@ticket.milestone_id), :width => "50%"
          }
        }
        row {
          cell(:width => "30%") {
            edit_ticket_label :text => "Tags:"
          }
          cell {
            text_box :id => "ticket_tag", :text => @ticket.tag, :width => "50%"
          }
        }
        row {
          edit_ticket_label :text => "Add Comment:", :width => "30%"
        }
        row {
          text_area :id => "ticket_comment", :width => "100%"
        }
        row {
          button :text => "Save Ticket", :id => "save_button", :players => "save_ticket", :width => 200
          button :text => "Cancel", :id => "cancel_edit_button", :players => "cancel_edit_ticket", :width => 200
        }
      }
      secondary_ticket_group {
        @ticket.versions.each_with_index do |version, index|
          version_spacer if index != 0
          row {
            version_created_by :text => version.created_by
          }
          row {
            version_timestamp :text => version.timestamp
          }
          version.changed_attributes.each do |attribute|
            version_changed_attribute :text => "#{attribute.name} changed from \"#{attribute.old_value}\" to \"#{attribute.new_value}\"\n"
          end
          row {
            version_comment :text => version.comment
          }
        end
      }
    end
  end
  
  def ticket_id
    return id.split("_")[1].to_i
  end
end