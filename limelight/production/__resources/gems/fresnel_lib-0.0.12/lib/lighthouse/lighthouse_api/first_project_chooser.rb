require "credential"

module Lighthouse
  module LighthouseApi
    class FirstProjectChooser
      def get_project_name
        if Credential.save_credentials?
          cached_project = Lighthouse::LighthouseApi.find_project(Credential.project_name)
          return cached_project.name if cached_project
        end
        return Lighthouse::LighthouseApi.first_project.name
      end
    end
  end
end