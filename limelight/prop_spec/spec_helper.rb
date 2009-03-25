$adapter = "memory"

def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../#{path}")
end

[
  "production/list_tickets/players",
  "production/list_tickets/stagehands",
  "production/login/players",
  "production/no_internet/players",
  "production/players",
  "production/add_project/players",
  "production",
  "production/lib",
  "production/__resources/gems/fresnel_lib-0.0.19/lib",
  "production/milestones/players"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'
require 'lighthouse/adapter'
require "credential_saver"

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

def create_mock_project(name = "One")
  return mock(Lighthouse::Project, :open_tickets => [], :milestone_titles => [""], :hyphenated_name => nil, :tag_names => [], :destroy_ticket => nil, :create_milestone => nil,
                                       :id => nil, :tickets_for_tag => [], :user_names => [""], :update_tickets => nil, :user_id => nil, :ticket_title => nil,
                                       :milestone_id => nil, :name => name, :all_states => ["new", "open", "resolved", "hold", "invalid"], :milestone_title => nil)
                                       
end

def setup_mocks
  CredentialSaver.stub!(:load_account_names).and_return([])
  @project = create_mock_project
                                       
  @lighthouse_client = mock("lighthouse module", :authenticate => nil, :add_ticket => nil, :milestones => [], :milestone_title => "", :get_starting_project_name => "One",
                                                 :find_project => @project, :projects => [@project], :ticket => nil, :project_names => ["one"], :add_project => nil)
  @ticket = mock("ticket", :null_object => true)
  @stage_info = mock("stage_info", :credential => nil, :current_project => @project,
                                   :current_ticket => @ticket, :current_ticket= => nil, :current_project_name => nil)
  @stage_manager = mock("stage_manager", :[] => @stage_info, :notify_of_project_change => nil, :client_for_stage => @lighthouse_client)
  producer.production.stage_manager = @stage_manager
end


