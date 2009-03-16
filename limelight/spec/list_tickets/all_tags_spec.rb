require File.dirname(__FILE__) + '/../spec_helper'
require "all_tags"

describe AllTags do
  before(:each) do
    @lighthouse_client = mock('lighthouse', :login_to => true)
    @all_tags, @scene, @production = create_player(AllTags, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:lighthouse_client => @lighthouse_client})

  end

  it "should tell the ticket_lister to clear the tags" do
    @all_tags.ticket_lister.should_receive(:clear_tag_filter)
    @all_tags.tag_lister.should_receive(:show_project_tags)
    @all_tags.list_all_tags
  end
  
end