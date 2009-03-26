require "stage_info"
require "credential_saver"

class StageManager
  
  def initialize
    @stage_info_list = {}
    CredentialSaver.load_saved.each do |credential|
      @stage_info_list[credential.account] = StageInfo.new(:credential => credential, :stage_manager => self)
    end
  end
  
  def self.each_stage
    account_names.each { |account_name| yield(account_name, "list_tickets") }
    yield("default", "login") if account_names.empty?
  end
  
  def attempt_login(account, username, password, remember_me, stage_name)
    credential = Credential.new(account, username, password, nil, remember_me)
    stage_info = StageInfo.new(:credential => credential, :stage_manager => self, :name => stage_name)
    @stage_info_list[stage_name] = stage_info
    if Lighthouse::LighthouseApi.login_to(credential)
      CredentialSaver.save(all_credentials)
      return true
    else
      return false
    end
  end
  
  def notify_of_project_change(project_name, stage_name)
    project = client_for_stage(stage_name).find_project(project_name)
    @stage_info_list[stage_name].current_project = project
    CredentialSaver.save(all_credentials)
  end
  
  def [](stage_name)
    return @stage_info_list[stage_name]
  end
  
  def notify_of_logout(stage_name)
    @stage_info_list[stage_name].reset
    CredentialSaver.save(all_credentials)
  end
  
  def client_for_stage(stage_name)
    credential = @stage_info_list[stage_name].credential
    update_lighthouse_client(credential) if credential.account != Lighthouse.account
    return Lighthouse::LighthouseApi
  end
  
  private ##################
  
  def update_lighthouse_client(credential)
    Lighthouse::LighthouseApi.login_to(credential)
  end
  
  def all_credentials
    list = []
    @stage_info_list.each_pair do |stage_name, stage_info|
      list << stage_info.credential
    end
    return list.compact
  end
  
  def self.account_names
    return CredentialSaver.load_account_names
  end
end