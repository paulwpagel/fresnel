module Lighthouse
  class ProjectMembership
    @@project_memberships = []
  
    class << self
      def find(*params)
        project_id = params[1][:params][:project_id]
        return @@project_memberships.find_all {|membership| membership.project_id == project_id}
      end
  
      def destroy_all
        @@project_memberships = []
      end
    
      def all_users_for_project(project_id)
        return []
      end
    end
  
  
    attr_reader :project_id
  
    def initialize(options = {})
      @project_id = options[:project_id]
    end
  
    def save
      @@project_memberships << self
    end  
  end
end