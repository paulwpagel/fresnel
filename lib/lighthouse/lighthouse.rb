require 'activeresource'
require "lighthouse/memory/project"
require "lighthouse/memory/project_membership"
require "lighthouse/memory/user"
require "lighthouse/memory/ticket"
require "lighthouse/memory/milestone"
require "lighthouse/memory/base"

project = Lighthouse::Project.new(:name => "fresnel")
Lighthouse::User.new(:name => "Marion Morison", :id => rand(1000))
project.save

milestone = Lighthouse::Milestone.new(:project_id => project.id, :title => "First Milestone")
milestone.save