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
  "production/__resources/gems/fresnel_lib-0.0.15/lib"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'
require 'lighthouse/adapter'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

def create_mock_project(name = "One")
  return mock(Lighthouse::Project, :open_tickets => [], :all_tickets => [], :milestone_titles => [""], :hyphenated_name => nil, :tag_names => [""], :destroy_ticket => nil,
                                       :id => nil, :tickets_for_tag => [], :user_names => [""], :update_tickets => nil, :user_id => nil, :ticket_title => nil,
                                       :milestone_id => nil, :name => name, :all_states => ["new", "open", "resolved", "hold", "invalid"], :milestone_title => nil)
                                       
end

def mock_client
  return mock("lighthouse module", :authenticate => nil, :add_ticket => nil, :milestones => [], :milestone_title => "", :destroy_ticket => nil,
                                                 :find_project => @project, :projects => [], :ticket => nil, :project_names => ["one"], :add_project => nil)
end

def mock_stage_manager
  @project = create_mock_project
  @current_ticket = mock("ticket", :null_object => true, :id => 12345)
  @lighthouse_client = mock_client
  @stage_info = mock("stage_info", :credential => nil, :client => @lighthouse_client, :current_project => @project,
                                   :current_ticket => @current_ticket, :current_ticket= => nil)
  @stage_manager = mock("stage_manager", :[] => @stage_info, :notify_of_project_change => nil, :notify_of_logout => nil)
  @stage = mock("stage", :name => "stage name")
end

def mock_lighthouse
  @project = create_mock_project
                                       
  @lighthouse_client = mock_client
  producer.production.lighthouse_client = @lighthouse_client
  mock_stage_manager
end

require 'spec/mocks/framework'
class Module
  cattr_accessor :prop_readers

  def prop_reader(*symbols)
    @@prop_readers = [] unless @@prop_readers
    @@prop_readers.concat(symbols)
  end 
  
  def clear_prop_readers
    @@prop_readers = []
  end
end

def create_player(player_name, stubbed_mocks)
  player = Object.new.extend(player_name)
  if Module.prop_readers
    Module.prop_readers.each do |prop_reader|
      prop = mock(prop_reader, :text => "", :text= => nil, :value => "")
      action = lambda {return prop}

      player_name.send(:define_method, prop_reader, action)
    end
  end

  stubs = stubbed_mocks.map do |mock_name, mocked_options|
    stub = mock(mock_name.to_s)
    player.stub!(mock_name).and_return(stub)
    mocked_options.each_pair do |method, return_value|
      stub.stub!(method).and_return(return_value)
    end
    stub
  end
  return player, *stubs
end

