require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "tag"

describe Tag do

  before(:each) do
    @tag, @scene, @production = create_player(Tag, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {})
    @tag.stub!(:text)                                                
    @tag.ticket_lister.stub!(:filter_by_tag)
    @tag.tag_lister.stub!(:activate)
    @tag.stub!(:id)
  end
  
  it "should tell the ticket_lister to filter by tag" do
    @tag.should_receive(:text).and_return("Tag One")
    @tag.ticket_lister.should_receive(:filter_by_tag).with("Tag One")
    
    @tag.tag
  end
  
  it "should tell the tag lister to activate itself" do
    @tag.should_receive(:id).and_return("tag_1")
    @tag.tag_lister.should_receive(:activate).with("tag_1")
    
    @tag.tag
  end
  
end