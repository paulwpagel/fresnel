require File.dirname(__FILE__) + '/../spec_helper'
require "add_project"
  
describe AddProject do
  
  before(:each) do
    mock_stage_manager
    @add_project, @scene, @production = create_player(AddProject, 
                                                :scene => {:load => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})  
    @add_project.project_name.stub!(:text).and_return("test project")
  end

  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @add_project.add_project
  end
  
  it "should add_project" do
    @add_project.project_name.should_receive(:text).and_return("test project")
    @add_project.public.should_receive(:text).and_return("True")
    
    @lighthouse_client.should_receive(:add_project).with({:name => "test project", :public => "True"})

    @add_project.add_project
  end
  
  it "should load list tickets" do
    @scene.should_receive(:load).with("list_tickets")

    @add_project.add_project
  end
  
  
  it "should not allow a blank project to be added" do
    @add_project.project_name.should_receive(:text).and_return("")
    @add_project.error_message.should_receive(:text=).with("Please enter a project name")
    
    @add_project.add_project
  end  
end