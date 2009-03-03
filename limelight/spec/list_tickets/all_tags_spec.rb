require File.dirname(__FILE__) + '/../spec_helper'
require "all_tags"

describe AllTags do
  before(:each) do
    mock_lighthouse
  end
  
  uses_scene :list_tickets
  
  it "should show the tickets from the drop down" do
    all_tags = scene.find("all_tags")
    ticket_type = mock("type_selector")
    scene.should_receive(:find).with("ticket_type").and_return(ticket_type)
    ticket_type.should_receive(:notify_ticket_master)
    
    all_tags.mouse_clicked(nil)
  end
end