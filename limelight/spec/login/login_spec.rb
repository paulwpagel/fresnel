$not_uses_scene = true
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper.rb")
require "login"

describe "Login" do
  
  before(:each) do
    @stage_manager = mock('stage_manager', :notify_of_login => nil)
    @stage = mock("stage", :name => "stage name", :attempt_login => true)
    @login, @scene, @production = create_player(Login, 
                                                :scene => {:load => nil, :find => @mock_prop, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})                                    
    @login.save_credentials.stub!(:checked?).and_return(false)
    @credential = mock("credential")
    Credential.stub!(:new).and_return(@credential)
  end

  it "should mock out correctly" do
    @login.should_not be_nil
    @scene.should_not be_nil
    @production.should_not be_nil
  end
  
  it "should authenticate user information" do
    @login.username.should_receive(:text).and_return("Paul Pagel")
    @login.password.should_receive(:text).and_return("wouldntyaouliketoknow")
    @login.account.should_receive(:text).and_return("checking")
    @login.save_credentials.stub!(:checked?).and_return(true)
    
    @stage_manager.should_receive(:attempt_login).with("checking", "Paul Pagel", "wouldntyaouliketoknow", true, "stage name").and_return(true)
    
    @login.login
  end
  
  it "should load list tickets on a successful login" do
    @stage_manager.stub!(:attempt_login).and_return(true)
    @scene.should_receive(:load).with("list_tickets")
    
    @login.login
  end

  it "errors when authentication fails " do
    @stage_manager.stub!(:attempt_login).and_return(false)
    @login.error_message.should_receive(:text=).with("Authentication Failed, please try again")
    @login.password.should_receive(:text=).with('')

    @login.login
  end

  it "wont error when authentication passes " do
    @stage_manager.stub!(:attempt_login).and_return(true)
    @login.error_message.should_not_receive(:text=).with('error_message', "Authentication Failed, please try again")
    @login.password.should_not_receive(:text=).with('password', '')

    @login.login
   end


  it "should display an error if there is no internet" do
    @stage_manager.stub!(:attempt_login).and_raise(SocketError)
    @login.error_message.should_receive(:text=).with("You must be connected to the internet to use Fresnel.")
    @login.password.should_receive(:text=).with( '')
    
    @login.login
  end
  
  it "should not load list tickets if there is no interweb" do
    @stage_manager.should_receive(:attempt_login).and_raise(SocketError)

    @scene.should_not_receive(:load).with("list_tickets")
    
    @login.login
  end
  
end
$not_uses_scene = false