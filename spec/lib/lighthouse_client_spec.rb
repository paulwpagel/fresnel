require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "lighthouse_client"

describe LighthouseClient do

  it "should get all projects" do
    client = LighthouseClient.new
    client.find_projects
  end
end
