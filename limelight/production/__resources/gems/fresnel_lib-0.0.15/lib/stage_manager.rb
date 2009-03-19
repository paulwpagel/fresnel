require 'lighthouse/lighthouse_api/base'
require "credential_saver"

class StageInfo
  attr_reader :client, :credential
  
  def initialize(options={})
    @credential = options[:credential]
    @client = Lighthouse::LighthouseApi
  end
end
class StageManager
  
  def initialize
    @stage_info_list = {}
  end
  
  def self.each_name
    account_names.each { |account_name| yield account_name }
    yield "default" if account_names.empty?
  end
  
  def attempt_login(account, username, password, remember_me, stage_name)
    credential = Credential.new(account, username, password, nil, remember_me)
    stage_info = StageInfo.new(:credential => credential)
    @stage_info_list[stage_name] = stage_info
    if stage_info.client.login_to(account, username, password)
      CredentialSaver.save(all_credentials)
      return true
    else
      return false
    end
  end
  
  def [](stage_name)
    stage_info = @stage_info_list[stage_name]
    credential = stage_info.credential
    stage_info.client.login_to(credential.account, credential.login, credential.password)
    return stage_info
  end
  
  private ##################
  
  def all_credentials
    list = []
    @stage_info_list.each_pair do |stage_name, stage_info|
      list << stage_info.credential
    end
    return list
  end
  
  def self.account_names
    return CredentialSaver.load_account_names
  end
end