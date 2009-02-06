# TODO - EWM - pull this logic out of here so it be better tested?
Credential.load_saved
if Credential.account
  first_scene = 'list_tickets'
else
  first_scene = 'login'
end

stage "default" do
  default_scene first_scene
  title "Fresnel"
  location [200, 25]
  size [1000, 800]
end
