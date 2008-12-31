require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/changed_attributes"

def mock_version(options={})
  diffable_attributes = mock("diffable_attributes", options)
  return mock("version", :diffable_attributes => diffable_attributes)
end

describe Fresnel::ChangedAttributes, "with no changed_attributes" do
  before(:each) do
    diffable_attributes = mock("diffable_attributes")
    @versions = [mock_version, mock_version]
    @ticket = mock("ticket")
  end

  it "should accept an array of versions and the ticket" do
    Fresnel::ChangedAttributes.new(@versions, @ticket)
  end
  
  it "should have no changed attributes" do
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)

    @changed_attributes.list.should == []
  end
end

describe Fresnel::ChangedAttributes, "with title changed" do
  before(:each) do
    @versions = [mock_version(:title => "Old Title")]
    @ticket = mock("ticket", :title => "Current Ticket Title")
    @changed_attributes = Fresnel::ChangedAttributes.new(@versions, @ticket)
  end

  it "should have on changed attribute" do
    @changed_attributes.list.size.should == 1  
  end
  
  it "should give the name of the attribute" do
    first_attribute = @changed_attributes.list[0]
    first_attribute.name.should == "title"
  end
  
  it "should give the old value" do
    first_attribute = @changed_attributes.list[0]
    first_attribute.old_value.should == "Old Title"
  end
  
  it "should give the new value from the ticket if the title hasn't changed again" do
    first_attribute = @changed_attributes.list[0]
    first_attribute.new_value.should == "Current Ticket Title"
  end
  
  it "should look ahead to the next version for the new title" do
    @versions << mock_version(:title => "New Title")
    
    first_attribute = @changed_attributes.list[0]
    first_attribute.new_value.should == "New Title"
  end
  
  it "should look ahead multiple versions if the first doesn't have it" do
    @versions << mock_version
    @versions << mock_version(:title => "Some Other New Title")

    first_attribute = @changed_attributes.list[0]
    first_attribute.new_value.should == "Some Other New Title"
  end
end