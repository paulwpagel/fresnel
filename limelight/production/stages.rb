require "stage_manager"
StageManager.each_stage do |stage_name, scene_name|
  stage stage_name do
    default_scene scene_name
    title "Fresnel - #{stage_name}"
    location [200, 25]
    size [1000, 800]
  end
end