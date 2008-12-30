require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Fresnel
  class Milestone
    def self.find(id)
      lighthouse_milestone = Lighthouse::Milestone.find(id)
      return self.new(lighthouse_milestone) if lighthouse_milestone
      return nil
    end
    
    def initialize(lighthouse_milestone)
    end
  end
end