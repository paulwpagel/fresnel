require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "project_selector"

describe ProjectSelector do

  before(:each) do
    @project = mock('project', :open_tickets => [])
    @lighthouse_client = mock('lighthouse', :find_project => @project)
    
    @project_selector, @scene, @production = create_player(ProjectSelector, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:lighthouse_client => @lighthouse_client, :current_project= => nil, :current_project => @project})
    @project_selector.stub!(:text)
    @project_selector.ticket_lister.stub!(:show_these_tickets)
    @project_selector.tag_lister.stub!(:show_project_tags)
    Credential.stub!(:project_name=)
    Credential.stub!(:save)
    Credential.stub!(:save_credentials?).and_return(true)
  end
    
  it "should set the project as the current project" do
    @project_selector.should_receive(:text).twice.and_return("Project Name")
    @lighthouse_client.should_receive(:find_project).with("Project Name").and_return(@project)
    @production.should_receive(:current_project=).with(@project)

    @project_selector.select_project
  end
  
  it "should send the ticket_lister new tickets" do
    ticket1 = mock('ticket1')
    ticket2 = mock('ticket2')
    @project.should_receive(:open_tickets).and_return([ticket1, ticket2])
    @production.should_receive(:current_project).and_return(@project)
    @project_selector.ticket_lister.should_receive(:show_these_tickets).with([ticket1, ticket2])

    @project_selector.select_project
  end
  
  it "should show the project's tags" do
    @lighthouse_client.should_receive(:find_project).ordered.and_return(@project)
    @project_selector.tag_lister.should_receive(:show_project_tags).ordered
    
    @project_selector.select_project
  end
  
  it "should set the credentials project name to the new project name" do
    @project_selector.should_receive(:text).any_number_of_times.and_return("one")
    Credential.should_receive(:project_name=).with("one")
    
    @project_selector.select_project
  end
  
  it "should save the credential" do
    Credential.should_receive(:save)
    
    @project_selector.select_project
  end
  
  it "should not alter the credentials if the user chose not to save them" do
    Credential.stub!(:save_credentials?).and_return(false)
    Credential.should_not_receive(:project_name=)
    Credential.should_not_receive(:save)
    
    @project_selector.select_project
  end
end