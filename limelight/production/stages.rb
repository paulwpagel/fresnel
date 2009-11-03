require "stage_manager"
StageManager.each_stage do |stage_name, scene_name|
  stage stage_name do
    default_scene scene_name
    title "Fresnel - #{stage_name}"
    location [200, 25]
    size [1000, 800]
  end
end



stage "devtool" do
  default_scene "devtool"
  title "Dev Tool"
  location [50, 25]
  size [100, 100]
  background_color "transparent"
  framed false
end
