module FreeAgent
  class Timeslip < Resource
    resource :timeslip

    resource_methods :default

    attr_accessor :user, :project, :task, :comment

    def follow_user
      FreeAgent::User.find(extract_id(@user))
    end

    def follow_project
      FreeAgent::Project.find(extract_id(@project))
    end

    def follow_task
      FreeAgent::Task.find(extract_id(@task))
    end

    decimal_accessor :hours
    date_accessor :dated_on, :created_at, :updated_at
  end
end
