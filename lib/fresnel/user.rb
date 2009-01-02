require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Fresnel
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