require 'lighthouse/lighthouse_api/base'

class StageInfo
  attr_reader :credential
  attr_accessor :current_ticket, :current_sort_order
  
  def initialize(options={})
    @credential = options[:credential]
    @stage_manager = options[:stage_manager]
    @stage_name = options[:name]
    @current_project = nil
  end
  
  def current_project=(project)
    @credential.project_name = project.name if project
    @current_project = project
  end
  
  def current_project
    @current_project = @stage_manager.client_for_stage(@stage_name).find_project(current_project_name) if @current_project.nil?
    return @current_project
  end
  
  def current_project_name
    return @credential.project_name if @credential
    return nil
  end
  
  def reset
    @credential = nil
    @current_ticket = nil
    @current_sort_order = nil
  end
end
