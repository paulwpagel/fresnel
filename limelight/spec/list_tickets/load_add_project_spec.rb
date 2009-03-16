require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "load_add_project"

describe LoadAddProject do

  before(:each) do
    @load_add_project, @scene, @production = create_player(LoadAddProject, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {})
  end
  
  it "should send it to the add_project scene" do
    @scene.should_receive(:load).with("add_project")
    
    @load_add_project.load_add_project
  end

end