require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "tag_lister"

module Limelight
  class Prop
  end
end

describe TagLister do
  
  before(:each) do
    @project = mock('project')
    @tag_lister, @scene, @production = create_player(TagLister, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:current_project => @project})
    @tag_lister.stub!(:remove_all)
  end
  
  it "should make a prop for one tag" do
    prop = mock('prop')
    @project.should_receive(:tag_names).and_return(["Tag One"])
    Limelight::Prop.should_receive(:new).with(:name => "tag", :text => "Tag One", :id => "tag_1").and_return(prop)
    @tag_lister.should_receive(:add).with(prop)
    
    @tag_lister.list_tags
  end
  
  it "should make a prop for the second tag" do
    prop = mock('prop')
    prop2 = mock('prop2')
    @project.should_receive(:tag_names).and_return(["Tag One", "Tag Two"])
    Limelight::Prop.should_receive(:new).with(:name => "tag", :text => "Tag One", :id => "tag_1").and_return(prop)
    Limelight::Prop.should_receive(:new).with(:name => "tag", :text => "Tag Two", :id => "tag_2").and_return(prop2)
    @tag_lister.should_receive(:add).with(prop)
    @tag_lister.should_receive(:add).with(prop2)
    
    @tag_lister.list_tags
  end

  it "sets a tag to be active" do
    prop = mock('prop')
    @project.should_receive(:tag_names).and_return(["Tag One"])
    active_prop = mock('active prop')
    active_prop.should_receive(:text).and_return("Tag One")
    @scene.should_receive(:find).with("id").and_return(active_prop)
    Limelight::Prop.should_receive(:new).with(:name => "active_tag", :text => "Tag One", :id => "tag_1").and_return(prop)
     @tag_lister.should_receive(:add).with(prop)
    @tag_lister.activate("id")
  end
  
  it "should remove_all before it lists" do
    @tag_lister.should_receive(:remove_all)
    @tag_lister.stub!(:list_tags)
    
    @tag_lister.show_project_tags
  end
  
  it "should remove_all before it activates a tag" do
    tag = mock("tag", :text => nil)
    @scene.stub!(:find).and_return(tag)
    @tag_lister.should_receive(:remove_all)
    @tag_lister.stub!(:list_tags)
    
    @tag_lister.activate("id")
  end
end
