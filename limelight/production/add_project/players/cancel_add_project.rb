module CancelAddProject
  
  def button_pressed(event)
    cancel
  end
  
  def cancel
    scene.load("list_tickets")
  end
  
end