$not_uses_scene = true
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper.rb")
require "login"

describe "Login" do
  
  before(:each) do
    @lighthouse_client = mock('lighthouse', :login_to => true)
    @mock_prop = mock('prop', :checked? => false)
    @login, @scene, @production = create_player(Login, 
                                                :scene => {:load => nil, :find => @mock_prop}, 
                                                :production => {:lighthouse_client => @lighthouse_client})                                    
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
    
    @lighthouse_client.should_receive(:login_to).with("checking", "Paul Pagel", "wouldntyaouliketoknow").and_return(true)
    
    @login.login
  end
  
  it "loads list tickets" do
    @scene.should_receive(:load).with("list_tickets")
    
    @login.login
  end

  it "errors when authentication fails " do
    @lighthouse_client.stub!(:login_to).and_return(false)
    @login.error_message.should_receive(:text=).with("Authentication Failed, please try again")
    @login.password.should_receive(:text=).with('')

    @login.login
  end

  it "wont error when authentication passes " do
    @lighthouse_client.stub!(:login_to).and_return(true)
    @login.error_message.should_not_receive(:text=).with('error_message', "Authentication Failed, please try again")
    @login.password.should_not_receive(:text=).with('password', '')

    @login.login
   end


  it "should display an error if there is no internet" do
    @lighthouse_client.stub!(:login_to).and_raise(SocketError)
    @login.error_message.should_receive(:text=).with("You must be connected to the internet to use Fresnel.")
    @login.password.should_receive(:text=).with( '')
    
    @login.login
  end
  
  it "should not load list tickets if there is no interweb" do
    @lighthouse_client.should_receive(:login_to).and_raise(SocketError)

    @scene.should_not_receive(:load).with("list_tickets")
    
    @login.login
  end
  
  it "should save the user's credentials if the check box is checked and authentication is successful" do
    @login.username.should_receive(:text).and_return("Paul Pagel")
    @login.password.should_receive(:text).and_return("wouldntyaouliketoknow")
    @login.account.should_receive(:text).and_return("checking")

    @mock_prop.stub!(:checked?).and_return(true)
    
    Credential.should_receive(:set).with(:account => "checking", :login => "Paul Pagel", :password => "wouldntyaouliketoknow", :save_credentials => true)
    Credential.should_receive(:save)

    @login.login
  end
  
  it "should set the credentials to nothing if the check box is not checked and authenticated is successful" do
    @mock_prop.stub!(:checked?).and_return(false)

    Credential.should_receive(:set).with()
    
    @login.login
  end
  
end
$not_uses_scene = false