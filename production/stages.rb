# TODO - EWM - pull this logic out of here so it be better tested?
credential = Credential.load_saved
if credential
  first_scene = 'project'
else
  first_scene = 'login'
end
stage "default" do
  default_scene first_scene
  title "Fresnel"
  location [200, 25]
  size [1000, 800]
end
