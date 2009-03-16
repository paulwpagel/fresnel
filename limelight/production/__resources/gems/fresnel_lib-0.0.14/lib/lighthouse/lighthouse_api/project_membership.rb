require "lighthouse/lighthouse_api/user"

module Lighthouse
  module LighthouseApi
    class ProjectMembership
      def self.all_users_for_project(project_id)
        begin
          memberships = Lighthouse::ProjectMembership.find(:all, :params => {:project_id => project_id})
        rescue  ActiveResource::UnauthorizedAccess
          return []
        end
        return memberships.collect{|membership| User.find_by_id(membership.user_id)}
      end
    end
  end
end