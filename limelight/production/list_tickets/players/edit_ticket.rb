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
      row {
        button :text => "Save Ticket", :id => "save_button", :players => "save_ticket", :width => 170
        button :text => "Cancel", :id => "cancel_save_button", :players => "cancel_save_ticket", :width => 170
      }
      row {
        cell(:horizontal_alignment => :left, :width => "100%") {
          edit_ticket_label :text => "Title:"
          text_box :id => "ticket_title", :width => 350, :text => @ticket.title
        }
      }
      row {
        cell(:horizontal_alignment => :left, :width => "60%", :border_width => 2, :border_color => "black", :rounded_corner_radius => "10") {
          edit_ticket_label :text => "Description:"
          ticket_description :id => "ticket_description", :text => @ticket.description
        }
        cell(:horizontal_alignment => :right, :width => "40%") {
          
          edit_ticket_label :text => "State:"
          combo_box :id => "ticket_state", :choices => @project.all_states, :value => @ticket.state
          
          edit_ticket_label :text => "Assigned User:"
          combo_box :id => "ticket_assigned_user", :choices => [""] + @project.user_names, :value => @ticket.assigned_user_name
          
          edit_ticket_label :text => "Milestone:"
          combo_box :id => "ticket_milestone", :choices => [""] + @project.milestone_titles, :value => @project.milestone_title(@ticket.milestone_id)
        }
      }
      row {
        edit_ticket_label :text => "Tags:", :width => "30%"
        text_box :id => "ticket_tag", :width => 350, :text => @ticket.tag, :width => "70%"
      }
      row{
        edit_ticket_label :text => "Add Comment:", :width => "30%"
        text_area :id => "ticket_comment", :width => "70%"
      }
      
      @ticket.versions.each_with_index do |version, index|
        row {
          change_message = ""
          version.changed_attributes.each do |attribute|
            change_message << "#{attribute.name} changed from \"#{attribute.old_value}\" to \"#{attribute.new_value}\"\n"
          end
          text =  "#{version.created_by}\n#{version.timestamp}\n#{change_message}\n#{version.comment}"
          label :name => "ticket_version_#{index + 1}", :id => "ticket_version_#{index + 1}", :text => text
        }

      end

    end
  end
  
  def ticket_id
    return id.split("_")[1].to_i
  end
end