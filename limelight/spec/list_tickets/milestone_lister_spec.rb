require File.dirname(__FILE__) + '/../spec_helper'
require "milestone_lister"

describe MilestoneLister do
  before(:each) do
    mock_stage_manager
    @project.stub!(:milestone_titles).and_return([])
    @milestone_lister, @scene, @production = create_player(MilestoneLister, 
                                                :scene => {:stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
  end
  
  it "should get the current project from the stage_manager using the stage name" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @milestone_lister.list_titles
  end
end