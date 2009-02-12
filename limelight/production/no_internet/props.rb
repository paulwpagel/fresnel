main {
  retry_group {
    label :id => "no_internet_message", :text => "You must be connected to the internet to use fresnel"
    button :id => "no_internet_retry_button", :text => "Retry", :players => "no_internet_retry"
  }
}