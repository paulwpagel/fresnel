require "lighthouse/lighthouse_api/ticket"
require "lighthouse/lighthouse_api/project_membership"

module Lighthouse
  module LighthouseApi
    class Project
      attr_reader :milestones, :id, :users, :all_tickets
          
      def initialize(lighthouse_project)
        @lighthouse_project = lighthouse_project
        @id = lighthouse_project.id
        @milestones = lighthouse_project.milestones
        @users = ProjectMembership.all_users_for_project(@id)
        @tags = @lighthouse_project.tags
        load_tickets
        @milestone_observers = []
      end
      
      def register_milestone_observer(observer)
        @milestone_observers << observer
      end
      
      def observe_milestones
        @milestone_observers.each { |observer| observer.observe }
      end
      
      def name
        return @lighthouse_project.name
      end
      
      def user_names
        @users.collect {|user| user.name }
      end
      
      def tag_names
        return @tags.collect { |tag| tag.name }
      end
      
      def user_id(user_name)
        return user_from_name(user_name).id if user_from_name(user_name)
        return nil
      end
      
      def user_name(user_id)
        return user_from_id(user_id).name if user_from_id(user_id)
        return nil
      end
      
      def destroy_ticket(ticket_id)
        ticket = Lighthouse::Ticket.find(ticket_id, :params => {:project_id => @id})
        ticket.destroy
        update_tickets
      end
        
      def open_tickets
        return @all_tickets.find_all { |ticket| open_states.include?(ticket.state) }
      end
      
      def tickets_for_tag(tag)
        return @all_tickets.find_all { |ticket| ticket.tags.include?(tag) }
      end
      
      def tickets_for_type(type)
        if type == "Open Tickets"
          return open_tickets
        else
          return all_tickets
        end
      end
      
      def ticket_title(id)
        ticket = @all_tickets.find { |ticket| ticket.id == id.to_i }
        return ticket.title if ticket
        return nil
      end
      
      def milestone_titles
        return @milestones.collect { |milestone| milestone.title }
      end
      
      def milestone_title(id)
        return milestone_from_id(id).title if milestone_from_id(id)
        return nil
      end
      
      def milestone_id(title)
        return milestone_from_title(title).id if milestone_from_title(title)
        return nil
      end
      
      def create_milestone(options)
        new_milestone = Lighthouse::Milestone.create(options.merge(:project_id => @id))
        update_milestone_list
        return new_milestone
      end
      
      def delete_milestone(id)
        Lighthouse::Milestone.delete(id, { :project_id => @id })
        update_milestone_list
      end
      
      def update_milestone(id, attributes)
        attributes.each_pair do |attribute, new_value|
          milestone_from_id(id).send(:attribute=, new_value) if milestone_from_id(id)
        end
      end
      
      def open_states
        return @lighthouse_project.open_states_list.split(",")
      end
      
      def closed_states
        return @lighthouse_project.closed_states_list.split(",")
      end
     
      def all_states
        return open_states + closed_states
      end
      
      def hyphenated_name
        return @lighthouse_project.name.downcase.gsub(" ", "-")
      end
      
      def update_tickets
        load_tickets
      end
      
      private ######################
      
      def load_tickets
        @all_tickets = Lighthouse::LighthouseApi::Ticket.find_tickets(self, "all")
      end
      
      def user_from_name(user_name)
        return @users.find { |user| user.name == user_name }
      end
      
      def user_from_id(user_id)
        return @users.find { |user| user.id == user_id }
      end
      
      def milestone_from_title(title)
        return @milestones.find { |milestone| milestone.title == title }
      end
      
      def milestone_from_id(id)
        return @milestones.find { |milestone| milestone.id == id }
      end
      
      def update_milestone_list
        @milestones = Lighthouse::Milestone.find(:all, :params => { :project_id => @id })
        observe_milestones
      end
    end
  end
end