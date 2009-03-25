# This file (init.rb) is the second file loaded (after production.rb) when a production is loaded.
# Initialization code for the production should go here.

# If your production is using external ruby source code that will be required in player modules, you may
# add the path to $: here.
# $: << File.expand_path(File.dirname(__FILE__) + "/../lib")

$: << File.expand_path(File.dirname(__FILE__) + "/milestones/players")
$: << File.expand_path(File.dirname(__FILE__) + "/list_tickets/players")
$: << File.expand_path(File.dirname(__FILE__) + "/list_tickets/stagehands")
$: << File.expand_path(File.dirname(__FILE__) + "/lib")
$: << File.expand_path(File.dirname(__FILE__))
$: << File.expand_path(File.dirname(__FILE__) + "/__resources/jars")
require "OpenWebsite.jar"
import "Browser"

# Acquires a reference to the production.
production = Limelight::Production["Fresnel"]

# This is the ideal place to assign values to production attributes.
if ARGV[1] and ARGV[1].downcase == "memory"
  $adapter = "memory"
else
  $adapter = "net"
end

require "lighthouse/adapter"
require 'lighthouse/lighthouse_api/base' # do i need this
require "stage_manager"
production.stage_manager = StageManager.new
require "prop"