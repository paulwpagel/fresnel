require File.dirname(__FILE__) + "/../spec_helper"
require "extra_account"

describe ExtraAccount do
  before(:each) do
    @stage = mock("stage")
    @theater = mock("theater", :add_stage => @stage)
    @producer = mock('producer', :open_scene => nil)
    @extra_account, @scene, @production = create_player(ExtraAccount, :scene => {}, :production => {:theater => @theater, :producer => @producer})
  end
  
  it "should create a new stage with a unique name" do
    @theater.should_receive(:add_stage).with(anything())
    
    @extra_account.open_extra_account
  end
  
  it "should open the stage" do
    @producer.should_receive(:open_scene).with("login", @stage)
    
    @extra_account.open_extra_account
  end
end