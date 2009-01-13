require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/project_helper")
require 'limelight/specs/spec_helper'

describe "Add Ticket Integration Test" do
  include LoginHelper
  include ProjectHelper
end