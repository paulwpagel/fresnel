# require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/adapter"

module Lighthouse
  module LighthouseApi
    class User
      def self.find_by_id(id)
        begin
          Lighthouse::User.find(id)
        rescue
          return nil
        end
      end
    end
  end
end