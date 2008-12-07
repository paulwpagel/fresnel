$: << File.expand_path(File.dirname(__FILE__) + "/../main/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'rubygems'
require 'spec'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../")
