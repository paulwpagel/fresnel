# require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/adapter"
require "lighthouse/lighthouse_api/user"

module Lighthouse
  module LighthouseApi
    class ProjectMembership
      def self.all_users_for_project(project_id)
        memberships = Lighthouse::ProjectMembership.find(:all, :params => {:project_id => project_id})
        return memberships.collect{|membership| User.find_by_id(membership.user_id)}
      end
    end
  end
end