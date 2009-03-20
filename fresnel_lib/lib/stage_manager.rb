require "stage_info"
require "credential_saver"

class StageManager
  
  def initialize
    @stage_info_list = {}
    CredentialSaver.load_saved.each do |credential|
      @stage_info_list[credential.account] = StageInfo.new(:credential => credential)
    end
  end
  
  def self.each_stage
    account_names.each { |account_name| yield(account_name, "list_tickets") }
    yield("default", "login") if account_names.empty?
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
  
  def notify_of_project_change(project_name, stage_name)
    #TODO - EWM this should probably just delegate to the stageinfo object, but we do want the current project to be cached.  do not find every time
    @stage_info_list[stage_name].credential.project_name = project_name
    @stage_info_list[stage_name].current_project = self[stage_name].client.find_project(project_name)
    CredentialSaver.save(all_credentials)
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