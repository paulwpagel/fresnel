require File.dirname(__FILE__) + '/../spec_helper'
require "all_tags"

describe AllTags do
  before(:each) do
    mock_lighthouse
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_master = mock("ticket_master")
    scene.stub!(:ticket_master).and_return(@ticket_master)
  end
  
  it "should tell the ticket_master to clear the tags" do
    all_tags = scene.find("all_tags")
    @ticket_master.should_receive(:clear_tag_filter)
    
    all_tags.mouse_clicked(nil)
  end
end