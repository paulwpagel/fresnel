main {
  center{
    input_secction {
      label :text => "Name: "
      text_box :id => "project_name", :width => 150
    } 
    input_secction {
      label :text => "Public : "
      combo_box :id => "public", :choices => ["True", "False"]
    }
    button :players => "add_project", :id => "add_project_button", :text => "Add Project", :width => 200
  }
}