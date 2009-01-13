require 'activeresource'
require "lighthouse/memory/project"
require "lighthouse/memory/user"
require "lighthouse/memory/ticket"
require "lighthouse/memory/milestone"

module Lighthouse
  
  def self.account=(value)
  end
  
  def self.authenticate(username, password)
    return true
  end
end

project = Lighthouse::Project.new(:name => "fresnel")
Lighthouse::User.new(:name => "Marion Morison", :id => rand(1000))
project.save

milestone = Lighthouse::Milestone.new(:project_id => project.id, :title => "First Milestone")
milestone.save