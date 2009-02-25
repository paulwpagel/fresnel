ticket_content {
  width "85%"
}

side_column {
  width "15%"
  right_border_width 6
  right_border_color "5A9ECF"
  height "96%"
}

sort_image {
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
  width "25%"
  top_padding 7
  bottom_padding 7
}

title_header {
  left_padding 39
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_title {
  left_padding 7
  height 20
  width "24%"
}

state_header {
  left_padding 12
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_state {
  height 20
  width "20%"
}

age_header {
  left_padding 12
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_formatted_age {
  height 20
  width "20%"
}

assigned_user_header {
  left_padding 12
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_assigned_user_name {
  height 20
  width "20%"
}

delete_ticket {
  background_image_fill_strategy "static"
  background_image "images/delete.png"
  height 20
  width "3%"
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
  width "100%"  
  hover {
    border_width 4
    border_color "A63101"
  }
}

ticket_comment {
  width 500
  height 80
}

cell {
  font_size 20
  padding 15
  horizontal_alignment :left 
}

row {
  width "100%"
  padding 3
}

version_cell {
  padding 15
  rounded_corner_radius "10"
  border_width 4
  border_color "006699"
  background_color "5A9ECF"
}

right_title{
  horizontal_alignment :right
  width "70%"
}

left_title {
  horizontal_alignment :left
  width "30%"
}

edit_ticket_label {
  font_size 20
}

heading {
  width "100%"
  horizontal_alignment :center
  font_style :bold
  font_size 24
}

delete_ticket_confirmation_main {
  float "on"
  x 0
  y 0
  width "100%"
  height "100%"
  background_color "blue"
  transparency "50"
  horizontal_alignment "center"
  vertical_alignment "center"
}

delete_ticket_confirmation_box {
  # transparency "0"

  height 200
  width 300
  background_color "#CCCCCC"
  rounded_corner_radius "10"
  border_width 2
  border_color "black"
  horizontal_alignment "center"
  vertical_alignment "center"
}

delete_ticket_button {
  # transparency "0"
  font_size 24
  height 50
  width 200
  background_color "green"
  rounded_corner_radius "10"
  border_width 2
  border_color "red"
  horizontal_alignment "center"
  vertical_alignment "center"
}