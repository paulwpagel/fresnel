require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "search"

describe Search do
  
  before(:each) do
    @search, @scene, @production = create_player(Search, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {})
  end

  
  it "should search tickets" do
    @search.search_box.should_receive(:text).and_return("criteria")
    @search.ticket_lister.should_receive(:search_on).with("criteria")
    
    @search.search
  end
end