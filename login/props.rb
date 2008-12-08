main {
  login_group {

    input_group {  
      label :text => "Account:"
      input :players => "text_box", :id => "account", :width => 200
    }

    input_group {
      label :text => "Username:"
      input :players => "text_box", :id => "username", :width => 200
      }
      
    input_group {  
      label :text => "Password:"
      input :players => "text_box", :id => "password", :width => 200
    }

    
    button :text => "Login", :players => "login", :width => 125
  }
}