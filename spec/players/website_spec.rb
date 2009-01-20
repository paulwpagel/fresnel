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
#   it "should respond to button_pressed" do
#     click_link
#   end
#   
#   def click_link
#     scene.find("website_link").button_pressed(nil)
#   end
# end