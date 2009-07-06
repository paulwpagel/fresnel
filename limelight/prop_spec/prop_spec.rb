require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'
require "prop"

describe "Limelight::Prop" do
  before(:each) do
    @casting_director = mock("casting_director", :fill_cast => nil)
    @scene = Limelight::Scene.new(:casting_director => @casting_director, :stage => @stage)
    @stage = mock("stage", :current_scene => @scene)
    @scene.stub!(:stage).and_return(@stage)
    @prop = Limelight::Prop.new(:id => "root", :name => "root_class")
    @scene << @prop
    @scene.illuminate
  end
  
  it "should add the spinner before yielding" do
    @scene.should_receive(:add).ordered
    @prop.should_receive(:name=).ordered
    @prop.show_spinner do
      @prop.name = "New Name"
    end
  end
  
  it "should remove the spinner after yielding " do
    @prop.should_receive(:name=).ordered
    @scene.should_receive(:remove).ordered
    @prop.show_spinner do
      @prop.name = "New Name"
    end
  end
  
  it "should not crash if someone tries to show the spinner while it is already shown" do
    lambda{@prop.show_spinner do
      @prop.show_spinner do
      end
    end}.should_not raise_error
    @scene.find("spinner").should be_nil
  end
  
  it "should not remove the spinner if the scene is not the current scene" do
    different_scene = mock("scene")
    @stage.stub!(:current_scene).and_return(different_scene)
    
    @scene.should_not_receive(:remove)
    @prop.show_spinner do
    end
  end
  
  it "should not crash if the stage is nil" do
    @scene.stub!(:stage).and_return(nil)
    
    @prop.show_spinner do
    end
  end
end