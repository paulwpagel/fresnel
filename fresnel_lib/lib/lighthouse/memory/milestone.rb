module Lighthouse
  class Milestone
    @@milestones = []
    
    def self.destroy_all
      @@milestones = []
    end
    
    def self.find(param1, param2)
      project_id = param2[:params][:project_id]
      return @@milestones.find_all { |milestone| milestone.project_id == project_id }
    end
    
    attr_reader :project_id, :id
    attr_accessor :title, :goals, :due_on
    
    def initialize(options = {})
      @project_id = options[:project_id]
      @title = options[:title]
      @id = nil
    end
    
    def save
      unless @id
        @id = rand 10000
        @@milestones << self
      end
    end
  end
end