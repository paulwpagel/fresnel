module Lighthouse
  class Milestone
    @@milestones = []
    
    def self.destroy_all
      @@milestones = []
    end
    
    def self.delete(id, params)
      @@milestones.delete_if { |milestone| milestone.id == id && milestone.project_id == params[:project_id] }
    end
    
    def self.create(params)
      milestone = Lighthouse::Milestone.new(params)
      milestone.save
      return milestone
    end
    
    def self.find(param1, param2)
      project_id = param2[:params][:project_id]
      return @@milestones.find_all { |milestone| milestone.project_id == project_id }
    end
    
    attr_reader :project_id, :id, :due_on
    attr_accessor :title, :goals
    
    def initialize(options = {})
      @project_id = options[:project_id]
      @title = options[:title]
      @goals = options[:goals]
      @id = nil
    end
    
    def due_on=(date)
      @due_on = Date.parse(date) rescue nil
    end
    
    def save
      unless @id
        @id = rand 10000
        @@milestones << self
      end
    end
  end
end