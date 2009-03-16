require File.dirname(__FILE__) + '/../spec_helper'
require "add_project"
  
describe AddProject do
  
  before(:each) do
    @lighthouse_client = mock('lighthouse', :add_project => nil)
    @add_project, @scene, @production = create_player(AddProject, 
                                                :scene => {:load => nil}, 
                                                :production => {:lighthouse_client => @lighthouse_client})  

  end

  it "should add_project" do
    @add_project.project_name.should_receive(:text).and_return("test project")
    @add_project.public.should_receive(:text).and_return("True")
    
    @lighthouse_client.should_receive(:add_project).with({:name => "test project", :public => "True"})

    @add_project.add_project
  end
  
  it "should load list tickets" do
    @add_project.project_name.should_receive(:text).and_return("test project")
    @scene.should_receive(:load).with("list_tickets")

    @add_project.add_project
  end
  
  
  it "should not allow a blank project to be added" do
    @add_project.project_name.should_receive(:text).and_return("")
    @add_project.error_message.should_receive(:text=).with("Please enter a project name")
    
    @add_project.add_project
  end  
end