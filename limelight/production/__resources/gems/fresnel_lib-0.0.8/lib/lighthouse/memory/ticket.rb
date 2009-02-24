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
    
    attr_reader :id, :project_id, :versions, :updated_at
    attr_accessor :state, :title, :body, :body_html, :assigned_user_id, :milestone_id, :tag
    
    def initialize(options={})
      @project_id = options[:project_id]
      set_initial_state(options[:state])
      @versions = []
      @tag = ""
      @title = options[:title]
    end
        
    def save
      unless @id
        @id = rand 10000
        @updated_at = Time.now
        @versions << TicketVersion.new(:body => body)
        @@tickets << self
      end
    end
    
    def created_at
      return @updated_at
    end
    
    def destroy
      @@tickets.delete_if {|ticket| ticket.id == self.id }
    end
    
    private #################################
    
    def set_initial_state(state)
      if state
        @state = state
      else
        @state = "new"
      end
    end
  end
end