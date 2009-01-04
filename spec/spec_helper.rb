def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../#{path}")
end

[
  "production/list_tickets/players",
  "production/list_tickets/stagehands",
  "production/view_ticket/players",
  "production/login/players",
  "production/add_ticket/players",
  "production/project/players",
  "lib"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

def mock_lighthouse
  @project = mock(Lighthouse::Project, :open_tickets => [], :milestone_titles => [""])  
  @lighthouse_client = mock("lighthouse module", :authenticate => nil, :add_ticket => nil, :milestones => [], :milestone_title => "",
                                                 :find_project => @project)
  producer.production.lighthouse_client = @lighthouse_client
end