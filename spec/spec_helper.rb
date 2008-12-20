$: << File.expand_path(File.dirname(__FILE__) + "/../production/ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/ticket/stagehands")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/view_ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/login/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/add_ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'spec'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

def mock_lighthouse
  @project = mock(Lighthouse::Project, :open_tickets => [])  
  @lighthouse_client = mock("lighthouse module", :authenticate => nil, :add_ticket => nil, :milestones => [], :find_project => @project)
  producer.production.lighthouse_client = @lighthouse_client
end