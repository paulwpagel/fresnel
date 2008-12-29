require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
require "fresnel/ticket"

module Fresnel
  class Project
    def initialize(lighthouse_project)
      @id = lighthouse_project.id
      @milestones = lighthouse_project.milestones
    end
    
    def open_tickets
      return Fresnel::Ticket.find(:all, :params => {:project_id => @id, :q => "state:open"})
    end
    
    def all_tickets
      return Fresnel::Ticket.find(:all, :params => {:project_id => @id, :q => "all"})
    end
    
    def milestone_titles
      return @milestones.collect { |milestone| milestone.title }
    end
  end
end