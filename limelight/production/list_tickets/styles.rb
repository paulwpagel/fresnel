main_ticket_group {
  background_color "cfe2ee"
  padding 10
  left_margin 12
  right_margin 12
  rounded_corner_radius 10
  border_width 2
  border_color "006699"
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
  font_size 20
}

version_spacer {
  width "100%"
  border_color "006699"
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
  height 50
}

icon_cell {
  height "100%"
  width "4%"
}

header_cell {  
  width "24%"
  top_padding 7
  bottom_padding 7
  height "100%"
}

title_header {
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_title {  
  height 20
}

state_header {
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_state {  
  height 20
}

age_header {
  font_size 24
  hover {
    text_color "CCCCCC"
  }
}
ticket_formatted_age {
  height 20
}

assigned_user_header {
  font_size 24
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
  width "3%"
}

add_ticket_group {
  top_padding 12
  bottom_padding 12
  background_color "5A9ECF"
}
ticket_in_list {
  extends :add_ticket_group
  width "100%"
  top_border_width 2
  border_color "006699"
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

tag {
  font_size 14
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

active_tag {
  font_size 16
  padding 10
  rounded_corner_radius "10"
  border_width 4
  border_color "red"
  background_color "5A9ECF"
  font_style :bold
  horizontal_alignment :center
  width "100%"  
}

ticket_comment {
  width 500
  height 80
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

heading_wrapper {
  top_padding 15
  width "100%"
  horizontal_alignment :center
}
heading {
  font_style :bold
  font_size 18
}

configure_milestones {
  background_image_fill_strategy "static"
  background_image "images/configure.png"
  height 16
  width 16
}

delete_ticket_confirmation_message {
  font_size 20
  width 500
  horizontal_alignment "center"
  vertical_alignment "center"
  padding 7
}
delete_ticket_confirmation_box {
  border_color "006699"
	background_color "cfe2ee"
  rounded_corner_radius "10"
  border_width 2
  horizontal_alignment "center"
  vertical_alignment "center"
  width 500
}

delete_ticket_button {
  font_size 24
  width "50%"
  border_color "006699"
  background_color "5A9ECF"
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