@@main_ticket_bg_color = "2060a0"
@@blue_border_color = "204060"
@@header_row_bg_color = "#f0c040"
@@secondary_bg_color = "f7f7ff"
@@header_text_color = "F6C522"
@@table_header_text_color = "2060a0"
main_ticket_group {
  secondary_background_color "FFFFFF" 
  background_color "DDDDDD"
  gradient :on  
  padding 20
  left_margin 12
  right_margin 12
  rounded_corner_radius 10
  border_width 2
  border_color @@blue_border_color
}

secondary_ticket_group {
  extends :main_ticket_group
  top_margin 7
}

cell {
  font_size 20
  right_padding 15
  horizontal_alignment :left 
}

row {
  width "100%"
  padding 3
}

edit_ticket_label {
  # font_size 20
  top_padding 5
}

add_ticket_label {
  width 130
  top_padding 7
}

version_spacer {
  width "100%"
  border_color @@blue_border_color
  bottom_border_width 2
  top_padding 8
  bottom_margin 8
}

version_created_by {
  font_style :bold
  font_size 16
}

version_timestamp {
  font_size 12
  text_color "444444"
  bottom_padding 3
}

version_changed_attribute {
  font_size 12
  width "100%"
  left_padding 7
}

version_comment {
  left_padding 5
  top_padding 5
  font_size 14
}

ticket_content {
  width "85%"
}

side_column {
  width "15%"
}

sort_image {
  background_image_fill_strategy "static"
  top_margin 9
  width 20
  height 23
}

ticket_table {
  width "100%"
  right_margin 15
  bottom_margin 15
  left_margin 15
  rounded_corner_radius 10
  padding 15
  border_width 1
  border_color "204060"
  secondary_background_color @@secondary_bg_color
  background_color "e0e0f0"
  gradient :on
  gradient_penetration 100
}

header_row {
  width "100%"
  transparency 100
  height 50
}

icon_cell {
  height "100%"
  width "4%"
}

header_cell {  
  width "24%"
  top_padding 7
  height "100%"
}

title_header {
  font_size 24
  text_color @@table_header_text_color
  font_style :bold
  hover {
    text_color "CCCCCC"
  }
}
ticket_title {  
  height 20
}

state_header {
  font_size 24
  text_color @@table_header_text_color
  font_style :bold
  hover {
    text_color "CCCCCC"
  }
}
ticket_state {  
  height 20
}

age_header {
  font_size 24
  text_color @@table_header_text_color
  font_style :bold
  hover {
    text_color "CCCCCC"
  }
}
ticket_formatted_age {
  height 20
}

assigned_user_header {
  font_size 24
  text_color @@table_header_text_color
  font_style :bold
  hover {
    text_color "CCCCCC"
  }
}
ticket_assigned_user_name {
  height 20
}

delete_ticket {  
  background_image_fill_strategy "static"
  background_image "images/remove.png"
  height 20
  left_margin 7
  width "3%"
}

add_ticket_group {
  top_padding 12
  bottom_padding 12
}
ticket_in_list {
  extends :add_ticket_group
  width "100%"
  top_border_width 2
  border_color @@blue_border_color
  hover {
    # background_color "F66722"
    # secondary_background_color "F6C522"
    background_color "F6C522"
    secondary_background_color "white"
    gradient :on
  }
}

search_bar {
  padding 10
}

title_bar {
  width "100%"
  left_margin 5
  right_margin 5
  background_color @@main_ticket_bg_color
  bottom_right_rounded_corner_radius 10
  bottom_left_rounded_corner_radius 10
  bottom_margin 7
  padding 3
}

ticket_filter {
  font_size 12
  text_color "0A3A68"
  padding 5
  rounded_corner_radius "10"
  border_width 1
  border_color @@blue_border_color
  secondary_background_color @@secondary_bg_color
  background_color "DDDDDD"
  gradient :on
  font_style :"bold italic"
  horizontal_alignment :center
  width "90%"
  left_margin "10"
  bottom_margin "3"
}
hover_ticket_filter {
  border_width 1
  border_color "F66722"
  font_size 16
}
milestone {
  extends :ticket_filter
  hover {
    extends :hover_ticket_filter
  }
}
tag {
  extends :ticket_filter
  hover {
    extends :hover_ticket_filter
  }
}
active_ticket_filter {
  font_size 16
  padding 5
  rounded_corner_radius "10"
  border_width 1
  border_color "black"
  background_color "DDDDDD"
  secondary_background_color "BBBBBB"
  gradient :on
  gradient_angle 270
  font_style :"bold italic"
  horizontal_alignment :center
  width "90%"
  left_margin "10"
  bottom_margin "3"
}
active_tag {
  extends :active_ticket_filter
}
active_milestone {
  extends :active_ticket_filter
}

ticket_comment {
  width 500
  height 80
}

version_cell {
  padding 15
  rounded_corner_radius "10"
  border_width 4
  border_color "CC6699"
  background_color @@secondary_bg_color
}

right_title{
  horizontal_alignment :right
  width "65%"
}

left_title {
  horizontal_alignment :left
  width "35%"
}

heading {
  width "100%"
  text_color @@header_text_color
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
  background_color "black"
  transparency "50"
  horizontal_alignment "center"
  vertical_alignment "center"
}
delete_ticket_confirmation_message {
  font_size 20
  width 500
  horizontal_alignment "center"
  vertical_alignment "center"
  padding 22
}
delete_ticket_confirmation_box {
  padding 20
  border_width 1
  border_color "204060"
  background_color @@secondary_bg_color
  secondary_background_color "DDD"
  gradient :on
  gradient_angle 270
  gradient_penetration 100
  rounded_corner_radius "10"
  horizontal_alignment "center"
  vertical_alignment "center"
  width 500
}

delete_ticket_button {
  font_size 24
  width "50%"
  border_color @@blue_border_color
  background_color @@secondary_bg_color
  rounded_corner_radius "10"
  border_width 2
  horizontal_alignment "center"
  vertical_alignment "center"
  margin 10
  padding 5
  hover {
    background_color "#CCCCCC"
  }
}
title_bar_label {
  top_padding 6
  left_padding 5
  font_style :bold
  text_color "white"
  font_size 14
}

title_bar_link {
  text_color "white"
  top_padding 6
  right_margin 35
  font_style :bold
  font_size 14
  bottom_border_width 1
  bottom_border_color "white"
  hover {
    text_color "ccc"
    bottom_border_color "ccc"
  }
}