require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Select Project Integration" do
  
  it "should be able to login" do
    scene = login_scene(producer)
     
    scene.find("account").text = "fresnel"
    scene.find("username").text = "Tommy James"
    scene.find("password").text = "abracadabrah"

    press_button("login_button", scene)
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "list_tickets"
    
    scene.find('project_selector').value = "Project Two"
    producer.production.current_project.name.should == "Project Two"
    scene.ticket_lister.children.size.should == lighthouse_client.find_project("Project Two").open_tickets.size
  end
  
  def lighthouse_client
    return producer.production.lighthouse_client
  end
end
