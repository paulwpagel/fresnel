module ProjectHelper
  def select_fresnel_project(scene)
    scene.find("fresnel").mouse_clicked(nil)
  end
end