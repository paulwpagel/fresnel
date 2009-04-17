require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "project_selector"

describe ProjectSelector do

  before(:each) do
    mock_stage_manager
    @project_selector, @scene, @production = create_player(ProjectSelector, 
                                                :scene => {:load => nil, :find => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @project_selector.stub!(:text)
    @project_selector.ticket_lister.stub!(:show_these_tickets)
    @project_selector.tag_lister.stub!(:show_project_tags)
    @project_selector.milestone_lister.stub!(:list_titles)
  end
    
  it "should notify the stage_manager of a change in current project" do
    @project_selector.should_receive(:text).and_return("Project Name")
    @stage.stub!(:name).and_return("stage name")
    @stage_manager.should_receive(:notify_of_project_change).with("Project Name", "stage name")
    
    @project_selector.select_project
  end
  
  it "should send the ticket_lister new tickets" do
    ticket1 = mock('ticket1')
    ticket2 = mock('ticket2')
    @project.should_receive(:open_tickets).and_return([ticket1, ticket2])
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    @project_selector.ticket_lister.should_receive(:show_these_tickets).with([ticket1, ticket2])

    @project_selector.select_project
  end
  
  it "should show the project's information" do
    @project_selector.ticket_lister.should_receive(:show_these_tickets).ordered
    @project_selector.tag_lister.should_receive(:show_project_tags).ordered
    @project_selector.milestone_lister.should_receive(:list_titles).ordered
    
    @project_selector.select_project
  end

end