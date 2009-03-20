require 'lighthouse/lighthouse_api/base'

class StageInfo
  attr_reader :client, :credential
  attr_accessor :current_ticket, :current_sort_order
  
  def initialize(options={})
    @credential = options[:credential]
    @client = Lighthouse::LighthouseApi
    @current_project = nil
  end
  
  def current_project=(project)
    @current_project = project
  end
  
  def current_project
    @current_project = @client.find_project(@credential.project_name) if @current_project.nil?
    return @current_project
  end
end
