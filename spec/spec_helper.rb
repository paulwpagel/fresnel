def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../#{path}")
end

[
  "production/list_tickets/players",
  "production/list_tickets/stagehands",
  "production/login/players",
  "production/no_internet/players",
  "production/players",
  "lib"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'
require "lighthouse/adapter"

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

def create_mock_project(name = "One")
  return mock(Lighthouse::Project, :open_tickets => [], :milestone_titles => [""], :hyphenated_name => nil, :tag_names => [""],
                                       :id => nil, :tickets_for_tag => [], :user_names => [""], :update_tickets => nil, :user_id => nil,
                                       :milestone_id => nil, :name => name, :all_states => ["new", "open", "resolved", "hold", "invalid"], :milestone_title => nil)
                                       
end

def mock_lighthouse
  @project = create_mock_project
                                       
  @lighthouse_client = mock("lighthouse module", :authenticate => nil, :add_ticket => nil, :milestones => [], :milestone_title => "",
                                                 :find_project => @project, :projects => [], :ticket => nil, :project_names => ["one"])
  producer.production.lighthouse_client = @lighthouse_client
end