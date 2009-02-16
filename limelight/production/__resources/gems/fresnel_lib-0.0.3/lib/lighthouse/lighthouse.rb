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


def create_ticket(options={})
  ticket = Lighthouse::Ticket.new(options)
  ticket.save
  return ticket
end
create_ticket(:project_id => project.id, :title => "Ticket on Project One")
create_ticket(:project_id => project.id, :title => "A Ticket", :state => "open")
create_ticket(:project_id => project.id, :title => "B Ticket", :state => "resolved")
create_ticket(:project_id => project.id, :title => "C Ticket", :state => "holding")

create_ticket(:project_id => project_two.id, :title => "Ticket on Project Two")