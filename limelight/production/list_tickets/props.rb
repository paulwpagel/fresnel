main {
  title_bar {
    left_title{
      combo_box :id => "project_selector", :players => "project_selector"
      image :players => "load_add_project", :id => "add_project", :image => "images/add.png", :width => 20, :height => 20, :top_margin => 4, :left_margin => 4
    }
    right_title{
      button :text => "Add Ticket", :width => 150, :id => "add_ticket_button", :players => "create_ticket"
      button :text => "Add Account", :width => 150, :id => "extra_account", :players => "extra_account"
      button :text => "Go to Website", :width => 150, :id => "website_link", :players => "website"
      button :text => "Logout", :width => 150, :id => "logout", :players => "title_bar"
    }
  }

  side_column {
    configure_milestones :id => "configure_milestones"
    heading :id => "tag_heading", :text => "Tags"
    all_tags :id => "all_tags", :text => "All Tags", :styles => "tag"
    tag_lister :id => "tag_lister"
  }
  
  ticket_content {
    search_bar {
      combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"], :width => 350, :right_margin => 200
   
      label :text => "Search", :font_size => 14, :width => 70
      search_box :players => "text_box", :name => "search_box",  :id => "search_box"
      button :players => "search", :id => "search_button", :text => "Search"
    }  

    ticket_table {
      header_row {
        icon_cell {}
        header_cell {
          label :id => "title_header", :text => "Title", :name => "title_header", :players => "ticket_sorter"
          sort_image :id => "title_image"
        }
        header_cell {
          label :id => "state_header", :text => "State", :name => "state_header", :players => "ticket_sorter"
          sort_image :id => "state_image"
        }
        header_cell {
          label :id => "age_header", :text => "Last Activity", :name => "age_header", :players => "ticket_sorter"
          sort_image :id => "age_image"
        }
        header_cell {
          label :id => "assigned_user_header", :text => "Assigned User", :name => "assigned_user_header", :players => "ticket_sorter"
          sort_image :id => "assigned_user_image"
        }
      }
      add_ticket_group :id => "add_ticket_group"
      ticket_lister :id => "ticket_lister"
    }
  }
}