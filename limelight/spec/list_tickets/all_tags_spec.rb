require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'
require "all_tags"

describe AllTags do
  before(:each) do
    mock_lighthouse
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_lister = mock("ticket_lister", :clear_tag_filter => nil)
    scene.stub!(:ticket_lister).and_return(@ticket_lister)
    @tag_lister = mock("tag_lister", :show_project_tags => nil)
    scene.stub!(:tag_lister).and_return(@tag_lister)
  end
  
  it "should tell the ticket_lister to clear the tags" do
    @ticket_lister.should_receive(:clear_tag_filter)
    
    all_tags.mouse_clicked(nil)
  end
  
  it "should show all tags" do
    @tag_lister.should_receive(:show_project_tags)
    all_tags.mouse_clicked(nil)
  end
  
  def all_tags
    return scene.find("all_tags")
  end
end