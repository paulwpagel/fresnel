# require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
# require 'website'
# 
# describe Website do
#   before(:each) do
#     mock_lighthouse
#     producer.production.current_project = mock('Project', :open_tickets => [])
#     Browser.stub!(:open)
#   end
#   
#   uses_scene :list_tickets
#   
#   it "should respond to mouse_clicked" do
#     click_link
#   end
#   
#   def click_link
#     scene.find("website_link").mouse_clicked(nil)
#   end
# end