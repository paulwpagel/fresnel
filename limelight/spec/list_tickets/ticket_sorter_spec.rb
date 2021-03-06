# require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
# # require 'limelight/specs/spec_helper'
# require "ticket_sorter"
# 
# describe TicketSorter do
# 
#   before(:each) do
#     mock_stage_manager
#     @first = ticket(:title => "a")
#     @second = ticket(:title => "b")
#     @third = ticket(:title => "c")
#     @tickets = [@second, @third, @first]
# 
#     @ticket_sorter, @scene, @production = create_player(TicketSorter, 
#                                                 :scene => {:load => nil, :find => nil, :stage => @stage}, 
#                                                 :production => {:stage_manager => @stage_manager})
#     @stage_info.stub!(:current_sort_order).and_return(nil)
#     @ticket_sorter.ticket_lister.stub!(:show_these_tickets)
#     @ticket_sorter.ticket_lister.stub!(:last_tickets).and_return(@tickets)
# 
#     @style = mock('style')
#     @ticket_sorter.title_image.stub!(:style).and_return(@stlye)
#     @ticket_sorter.state_image.stub!(:style).and_return(@stlye)
#     @ticket_sorter.age_image.stub!(:style).and_return(@stlye)
#     @ticket_sorter.assigned_user_image.stub!(:style).and_return(@stlye)
#   end
#   # before(:each) do
#   #   mock_lighthouse
#   #   @first = ticket(:title => "a")
#   #   @second = ticket(:title => "b")
#   #   @third = ticket(:title => "c")
#   #   @tickets = [@second, @third, @first]
#   # end
#   # 
#   # uses_scene :list_tickets
#   # 
#   # before(:each) do
#   #   scene.production.current_sort_order = nil
#   #   scene.ticket_lister.stub!(:show_these_tickets)
#   #   scene.ticket_lister.stub!(:last_tickets).and_return(@tickets)
#   #   title_image.style.stub!(:background_image=)
#   #   state_image.style.stub!(:background_image=)
#   #   age_image.style.stub!(:background_image=)
#   #   assigned_user_image.style.stub!(:background_image=)
#   # end
#   
#   describe "sort by title" do
#     it "should get the appropriate tickets from the ticket lister" do
#       @ticket_sorter.ticket_lister.should_receive(:last_tickets).and_return([])
#           
#       sort_by_title
#     end
#   
#     it "should list the tickets by title" do
#       scene.ticket_lister.should_receive(:show_these_tickets).with([@first, @second, @third])
#     
#       sort_by_title
#     end
#   
#     it "should ignore case while searching" do
#       @first = ticket(:title => "a")
#       @second = ticket(:title => "B")
#       @tickets = [@second, @first]
#       scene.ticket_lister.stub!(:last_tickets).and_return(@tickets)
#     
#       scene.ticket_lister.should_receive(:show_these_tickets).with([@first, @second])
#     
#       sort_by_title
#     end
#   
#     it "should keep track of ascending vs descending" do
#       sort_by_title
#     
#       scene.production.current_sort_order.should == "ascending"
#     end
#   
#     it "should set the image to ascending" do
#       title_image.style.should_receive(:background_image=).with("images/ascending.png")
#       
#       sort_by_title        
#     end
#     
#     describe "current_sort_order is ascending" do
#       before(:each) do
#         scene.production.current_sort_order = "ascending"
#       end
#     
#       it "should the current order is ascending, it should sort descending" do
#         scene.ticket_lister.should_receive(:show_these_tickets).with([@third, @second, @first])
#     
#         sort_by_title
#       end
#         
#       it "should toggle the current_sort_order" do
#         sort_by_title
#     
#         scene.production.current_sort_order.should == "descending"
#       end
#       
#       it "should set the image to descending" do
#         title_image.style.should_receive(:background_image=).with("images/descending.png")
#         
#         sort_by_title        
#       end
#     end  
#   end
#   
#   describe "sort by state" do
#     before(:each) do
#       scene.ticket_lister.stub!(:last_tickets).and_return([])
#     end
#     
#     it "should call ticket lister with the appropriate tickets" do
#       @first = ticket(:state => "a")
#       @second = ticket(:state => "B")
#       @tickets = [@second, @first]
#       scene.ticket_lister.stub!(:last_tickets).and_return(@tickets)
#       
#       scene.ticket_lister.should_receive(:show_these_tickets).with([@first, @second])
#       
#       scene.find("state_header").mouse_clicked(nil)
#     end
#     
#     it "should set the state image" do
#       state_image.style.should_receive(:background_image=).with("images/ascending.png")
#       
#       scene.find("state_header").mouse_clicked(nil)
#     end
#   end
#   
#   describe "sort by age" do
#     it "should call ticket lister with the appropriate tickets" do
#       @first = ticket(:age => Time.now - 500)
#       @second = ticket(:age => Time.now + 500)
#       @tickets = [@second, @first]
#       scene.ticket_lister.stub!(:last_tickets).and_return(@tickets)
#       
#       scene.ticket_lister.should_receive(:show_these_tickets).with([@first, @second])
#       
#       scene.find("age_header").mouse_clicked(nil)
#     end
#   end
#   
#   describe "sort by assigned_user_name" do
#     it "should call ticket lister with the appropriate tickets" do
#       @first = ticket(:assigned_user_name => "a")
#       @second = ticket(:assigned_user_name => "B")
#       @tickets = [@second, @first]
#       scene.ticket_lister.stub!(:last_tickets).and_return(@tickets)
#       
#       scene.ticket_lister.should_receive(:show_these_tickets).with([@first, @second])
#       
#       scene.find("assigned_user_header").mouse_clicked(nil)
#     end
#   end
# 
#   it "should clear the sort background_images of all the columns" do
#     title_image.style.should_receive(:background_image=).with("")
#     state_image.style.should_receive(:background_image=).with("")
#     age_image.style.should_receive(:background_image=).with("")
#     assigned_user_image.style.should_receive(:background_image=).with("")
#     
#     sort_by_title
#   end
#   
#   def title_image
#     return scene.find("title_image")
#   end
#   
#   def state_image
#     return scene.find("state_image")
#   end
#   
#   def age_image
#     return scene.find("age_image")
#   end
#   
#   def assigned_user_image
#     return scene.find("assigned_user_image")
#   end
#   
#   def ticket(options)
#     return mock("ticket #{options}", options)
#   end
#   
#   def sort_by_title
#     scene.find("title_header").mouse_clicked(nil)
#   end
# end