require 'lighthouse/lighthouse_api/base'

class StageInfo
  attr_reader :client, :credential
  attr_accessor :current_project, :current_ticket, :current_sort_order
  
  def initialize(options={})
    @credential = options[:credential]
    @client = Lighthouse::LighthouseApi
  end
end
