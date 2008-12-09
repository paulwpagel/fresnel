$: << File.expand_path(File.dirname(__FILE__) + "/../ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../view_ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../login/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'spec'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../")
