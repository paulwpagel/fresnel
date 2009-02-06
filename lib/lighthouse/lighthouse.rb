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

project_two = Lighthouse::Project.new(:name => "Project Two")
Lighthouse::User.new(:name => "Marion Morison", :id => rand(1000))
project_two.save

milestone = Lighthouse::Milestone.new(:project_id => project.id, :title => "First Milestone")
milestone.save

ticket = Lighthouse::Ticket.new(:project_id => project.id)
ticket.title = "Ticket on Project One"
ticket.save

ticket_two = Lighthouse::Ticket.new(:project_id => project_two.id)
ticket_two.title = "Ticket on Project Two"
ticket_two.save