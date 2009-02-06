require "credential"

module Lighthouse
  module LighthouseApi
    class FirstProjectChooser
      def get_project
        if Credential.save_credentials?
          cached_project = Lighthouse::LighthouseApi.find_project(Credential.project_name)
          return cached_project if cached_project
        end
        return Lighthouse::LighthouseApi.projects[0]
      end
    end
  end
end