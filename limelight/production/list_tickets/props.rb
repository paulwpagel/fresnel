main {
  title_bar {
    left_title{
      title_bar_label :text => "Select Project:"
      combo_box :id => "project_selector", :players => "project_selector", :width => 175
      image :players => "load_add_project", :id => "add_project", :image => "images/add.png", :width => 20, :height => 20, :top_margin => 4, :left_margin => 4, :styles => "icon"
    }
    right_title{
      title_bar_link :text => "Add Ticket", :id => "add_ticket_button", :players => "create_ticket"
      title_bar_link :text => "Add Account", :id => "extra_account", :players => "extra_account"
      title_bar_link :text => "Go to Website", :id => "website_link", :players => "website"
      title_bar_link :text => "Logout", :id => "logout", :players => "title_bar"
    }
  }

  side_column {
    heading_wrapper {
      heading :text => "Milestones"
      configure_milestones :id => "configure_milestones"
    }
  
    milestone_lister :id => "milestone_lister"
    
    heading_wrapper {
      heading :id => "tag_heading", :text => "Tags"
    }
    all_tags :id => "all_tags", :text => "All Tags", :styles => "tag"
    tag_lister :id => "tag_lister"
  }
  
  ticket_content {
    search_bar {
      combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"], :width => 350, :right_margin => 100
   
      label :text => "Search:", :font_size => 14, :width => 60, :top_padding => 7
      search_box :players => "text_box", :name => "search_box",  :id => "search_box", :width => 200
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