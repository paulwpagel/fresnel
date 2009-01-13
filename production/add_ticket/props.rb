main {
  add_ticket_group {

    input_group {
      label :text => "Title:"
      input :players => "text_box", :id => "title", :width => 200
      }
    
    input_group {  
      label :text => "Describe the problem:"
      input :players => "text_box", :id => "description", :width => 200
    }
  
    input_group{
      label :text => "Milestone:"
      input :players => 'combo_box', :id => 'milestones'
    }

    input_group{
      label :text => "Who's Responsible:"
      input :players => 'combo_box', :id => 'responsible_person'
    }
    input_group{
      label :text => "Tags"
      input :players => 'text_box', :id => 'tags'
    }
    
    
    button :text => "Add Ticket", :players => "add_ticket", :width => 125, :id => "add_ticket_button"
  }
}