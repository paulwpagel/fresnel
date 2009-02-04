sort_image {
  # background_image "images/desc.png"
  background_image_fill_strategy "static"
  top_margin 9
  width 20
  height 23
}
ticket_table {
  width "100%"
  margin 15
  border_width 1
  border_color "#000000"
}
header_row {
  width "100%"
  background_color "#FFFFFF"
}
header_cell {
  top_padding 7
  bottom_padding 7
}
title_header {
  left_padding 12
  font_size 24
  width 280
  hover {
    text_color "CCCCCC"
  }
}
ticket_title {
  width 300
}
state_header {
  left_padding 12
  font_size 24
  width 130
  hover {
    text_color "CCCCCC"
  }
}
ticket_state {
  width 150
}
ticket_formatted_age {
  width 200
}
age_header {
  left_padding 12
  font_size 24
  width 180
  hover {
    text_color "CCCCCC"
  }
}

assigned_user_header {
  left_padding 12
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_in_list {
  padding 12
  width "100%"
  top_border_width 2
  border_color "006699"
  background_color "5A9ECF"
  hover {
      background_color "DDDDDD"
    }
}

search_bar {
  padding 10
}

title_bar {
  width "100%"
  background_color "5A9ECF"
}

add_ticket_group {
  width 500
}

tag {
  font_size 16
  padding 10
  rounded_corner_radius "10"
  border_width 4
  border_color "006699"
  background_color "5A9ECF"
  font_style :bold
  horizontal_alignment :center
  width "20%"  
  hover {
    border_width 4
    border_color "A63101"
  }
}

ticket_comment {
  width 500
  height 80
}