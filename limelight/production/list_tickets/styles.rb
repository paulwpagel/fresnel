@@main_ticket_bg_color = "2060a0"
@@blue_border_color = "204060"
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
  border_width 1
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

content_pane{
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
  rounded_corner_radius 10
  left_padding 15
  right_padding 15
  top_padding 10
  bottom_padding 10
  border_width 1
  border_color "204060"

  background_color "e0e0f0"
  secondary_background_color @@secondary_bg_color
  gradient :on
}

header_row {
  width "100%"
  transparency 100
  height 32
  vertical_alignment :center
}

icon_cell {
  height "100%"
  width "4%"
}

header_cell {  
  width "24%"
  height "100%"
}

title_header {
  font_size 20
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
  top_padding 8
  bottom_padding 7
}
ticket_in_list {
  extends :add_ticket_group
  width "100%"
  top_border_width 1
  border_color @@blue_border_color
  hover {
    # background_color "F66722"
    # secondary_background_color "F6C522"
    background_color "F6C522"
    secondary_background_color "white"
    gradient :on
  }
}

search_label {
  font_size 20
  width 80
  top_padding 4
  font_style :bold
  text_color @@table_header_text_color
}

search_bar {
  padding 7
}

title_bar {
  width "100%"
  left_margin 5
  right_margin 5
	background_color "2060a0"
  secondary_background_color "74a3d0"
  gradient :on
  bottom_right_rounded_corner_radius 10
  bottom_left_rounded_corner_radius 10
  bottom_margin 7
  padding 3
}

filter_section {
  bottom_margin 20
  background_color "e0e0f0"
  secondary_background_color @@secondary_bg_color
  gradient :on
  left_margin 10
  bottom_margin 10
  width "93%"
  horizontal_alignment :center
  top_padding 7
  bottom_padding 7
  rounded_corner_radius 10
  border_width 1
  border_color @@blue_border_color
}
ticket_filter {
  font_size 12
  text_color "333"
  padding 3
  # rounded_corner_radius "10"
  # border_width 1
  # border_color @@blue_border_color
  # secondary_background_color @@secondary_bg_color
  # background_color "DDDDDD"
  # gradient :on
  font_style :bold
  width "100%"
  horizontal_alignment :center
  # left_margin "10"
  # bottom_margin "3"
}
hover_ticket_filter {
	background_color "2060a0"
  secondary_background_color "74a3d0"
  gradient :on
  text_color @@secondary_bg_color
  # border_width 1
  # border_color "F66722"
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
  font_size 12
  padding 3
  font_style :bold
  width "100%"
  horizontal_alignment :center
  extends :hover_ticket_filter
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

heading_wrapper {
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  padding 3
}
heading {
  text_color @@table_header_text_color
  font_style :bold
  font_size 18
}

delete_ticket_confirmation_main {
  float "on"
  x 0
  y 0
  width "100%"
  height "100%"
  horizontal_alignment "center"
  vertical_alignment "center"
}
delete_ticket_confirmation_message {
  font_size 20
  width 500
  horizontal_alignment "center"
  vertical_alignment "center"
  padding 22
  text_color "333"
}
delete_ticket_confirmation_box {
  padding 20
  border_width 1
  border_color :black
  background_color @@secondary_bg_color
  # secondary_background_color "DDD"
  # gradient :on
  gradient_angle 270
  gradient_penetration 100
  horizontal_alignment "center"
  vertical_alignment "center"
  width 500
}

delete_ticket_button {
  font_size 20
  width "30%"
  background_color "e0e0f0"
  secondary_background_color @@secondary_bg_color
  gradient :on
  text_color "333"
  border_color @@blue_border_color
  # background_color @@secondary_bg_color
  rounded_corner_radius "10"
  border_width 1
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

create_milestone_form {
  top_margin 50
  left_margin 10
  width "45%"
  rounded_corner_radius 10
  border_width 1
  border_color "204060"

  background_color "e0e0f0"
  secondary_background_color @@secondary_bg_color
  gradient :on
}
 
existing_milestones {
  extends :create_milestone_form
  bottom_padding 10
}

configure_milestones {
  background_image_fill_strategy "static"
  background_image "images/configure.png"
  height 16
  width 16
  hover {}
}

configure_milestones_wrapper {
  float "on"
  x 0
  y 0
  width "100%"
  height "100%"

  background_color "2060a0"
  secondary_background_color "74a3d0"
  gradient :on

  horizontal_alignment "center"
  vertical_alignment "center"
}

configure_milestones_header {
  height "35"
  background_color "2060a0"
  secondary_background_color "74a3d0"
  gradient :on
	text_color :white
  width "100%"
  horizontal_alignment :center
  vertical_alignment :center
  bottom_left_rounded_corner_radius 10
  bottom_right_rounded_corner_radius 10
  left_margin 5
  right_margin 5
  float :on
  x 0
  y 0
  horizontal_alignment :center
}
configure_milestones_header_text {
  font_size 24
  text_color :white
  width "50%"
  left_padding 30
}

milestone_input {
  width "50%"
}

delete_milestone {
  background_image_fill_strategy "static"
  background_image "images/remove.png"
  height 20
  width 20
}
edit_milestone_row {
  width "100%"
}
milestone_header_row {
  width "100%"
  left_padding 15
  bottom_padding 5
  top_padding 7
}
existing_milestone {
  font_size 14
  width "100%"
  top_padding 5
  bottom_padding 5
  left_padding 15
  right_padding 15
  hover {
    background_color "2060a0"
    secondary_background_color "74a3d0"
    gradient :on
    text_color "DDDDDD"
  }
}
existing_milestones_header {
  font_size 18
  width "100%"
  bottom_border_width 2
  bottom_border_color "black"
  bottom_margin 7
}
edit_milestone_wrapper {
 background_color "FFFFFF"
 secondary_background_color "DDDDDD"
 gradient :on
 gradient_angle 270
 gradient_penetration 100
 border_color "006699"
 rounded_corner_radius "10"
 border_width 1
 padding 7
 left_margin 15
 right_margin 15
 top_margin 5
 bottom_margin 5
}
milestone_input_group {
  width "100%"
  left_padding 17
  right_padding 17
  bottom_padding 15
}
