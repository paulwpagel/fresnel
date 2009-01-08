require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/user"

module Lighthouse
  module LighthouseApi
    class Membership
      def self.all_user_names(project_id)
        memberships = Lighthouse::Membership.find(:all, :params => {:project_id => project_id})
        return memberships.collect{|membership| User.user_name_for_id(membership.user_id)}
      end
    end
  end
end