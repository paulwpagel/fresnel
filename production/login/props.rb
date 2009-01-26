main {
  header :text => "Fresnel"
  login_group {

    error_message :id => "error_message"
    
    input_group {  
      label :text => "Account:"
      input :players => "text_box", :id => "account", :width => 270
    }

    input_group {
      label :text => "Username:"
      input :players => "text_box", :id => "username", :width => 270
      }
      
    input_group {  
      label :text => "Password:"
      input :players => "password_box", :id => "password", :width => 270
    }
    
    input_group {
      label :text => "Remember Me:"
      input :players => "check_box", :id => "save_credentials"
    }
    
    button_group {
      button :text => "Login", :players => "login", :id => "login_button"
    }    
  }
}