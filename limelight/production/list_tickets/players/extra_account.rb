module ExtraAccount
  def mouse_clicked(event)
    open_extra_account
  end
  
  def open_extra_account
    new_stage = production.theater.add_stage("stage #{rand 100000}")
    new_stage.size = [1000, 800]
    new_stage.title = "Fresnel"
    production.producer.open_scene("login", new_stage)
  end
end