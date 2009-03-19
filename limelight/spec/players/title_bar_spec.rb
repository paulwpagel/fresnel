require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'title_bar'

describe "title_bar" do

  before(:each) do
    Credential.stub!(:clear_saved)
    mock_stage_manager
    @title_bar, @scene, @production = create_player(TitleBar, 
                                                :scene => {:load => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
  end
      
  it "should notify the stage manager of a logout" do
    @title_bar.stub!(:id).and_return("logout")
    @stage_manager.should_receive(:notify_of_logout).with("stage name")
    
    @title_bar.title_bar
  end
  
  it "should go back to the login page on logout" do
    @title_bar.stub!(:id).and_return("logout")
    @scene.should_receive(:load).with("login")
    
    @title_bar.title_bar
  end
  
  it "should have other links to other scenes" do
    @title_bar.stub!(:id).and_return("some scene")
    @scene.should_receive(:load).with("some scene")
    
    @title_bar.title_bar
  end
  
  def press(id)
    scene.find(id).button_pressed(@event)
  end
end
