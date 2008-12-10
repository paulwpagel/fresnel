$: << File.expand_path(File.dirname(__FILE__) + "/../production/ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/view_ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/login/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'spec'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")
