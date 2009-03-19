module ExtraAccount
  def button_pressed(event)
    open_extra_account
  end
  
  def open_extra_account
    new_stage = production.theater.add_stage("some name")
    new_stage.size = [1000, 800]
    new_stage.title = "Fresnel"
    production.producer.open_scene("login", new_stage)
  end
end