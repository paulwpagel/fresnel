#- Copyright 2008 8th Light, Inc.
#- Limelight and all included source files are distributed under terms of the GNU LGPL.

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
    
    button :text => "Add Ticket", :players => "ticket", :width => 125
  }
}