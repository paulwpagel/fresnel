module Lighthouse
  class Ticket
    class TicketVersion
      attr_reader :body
      def initialize(options = {})
        @body = options[:body]
      end
    end

    @@tickets = []
    
    def self.destroy_all
      @@tickets = []
    end
    
    def self.find(param_one, param_two)
      query = param_two[:params][:q]
      project_id = param_two[:params][:project_id]
      if param_one == :all && query == "all"
        return @@tickets.find_all { |ticket| ticket.project_id == project_id  }
      elsif param_one == :all && query == "state:open"
        return @@tickets.find_all { |ticket| ticket.project_id == project_id && ticket.state == "open" }
      else
        return @@tickets.find {|ticket| ticket.id == param_one}
      end
    end
    
    attr_reader :id, :project_id, :versions
    attr_accessor :state, :title, :body, :body_html, :assigned_user_id, :milestone_id, :tags
    
    def initialize(options={})
      @project_id = options[:project_id]
      @state = "new"
      @versions = []
    end
        
    def save
      unless @id
        @id = rand 10000
        @versions << TicketVersion.new(:body => body)
        @@tickets << self
      end
    end
  end
end