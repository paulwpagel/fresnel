main {
  add_ticket {

    input_group {
      label :text => "Title:"
      input :players => "text_box", :id => "title", :width => 200
      }
      
    input_group {  
      label :text => "Description:"
      input :players => "text_box", :id => "description", :width => 200
    }
    
    input_group{
      label :text => "Milestone:"
      input :players => 'combo_box', :id => 'milestones'
    }
    
    button :text => "Add Ticket", :players => "ticket", :width => 125
  }
}