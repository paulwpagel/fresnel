require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'title_bar'

describe "title_bar" do

  before(:each) do
    @title_bar, @scene, @production = create_player(TitleBar, 
                                                :scene => {:load => nil}, 
                                                :production => {})
  end
      
  it "should log the user out when the logout button is clicked" do
    @title_bar.stub!(:id).and_return("logout")
    Credential.should_receive(:clear_saved)
    
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
