# This file (init.rb) is the second file loaded (after production.rb) when a production is loaded.
# Initialization code for the production should go here.

# If your production is using external ruby source code that will be required in player modules, you may
# add the path to $: here.
$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/ticket/players")
$: << File.expand_path(File.dirname(__FILE__) + "/../production/ticket/stagehands")

# Acquires a reference to the production.
production = Limelight::Production["Fresnel"]

# Require any source code that will be used by the production.
#require 'seomthing'

# This is the ideal place to assign values to production attributes.

# Development
require 'lighthouse/memory/base'
production.lighthouse_client = Lighthouse::Memory

# Real App
# require 'lighthouse/lighthouse_api/base'
# production.lighthouse_client = Lighthouse::LighthouseApi