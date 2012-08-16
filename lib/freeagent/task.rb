module FreeAgent
  class Task < Resource
    resource :task

    resource_methods :find, :filter, :update, :delete

    attr_accessor :project, :name, :is_billable, :billing_period, :status

    decimal_accessor :billing_rate

    decimal_accessor :created_at, :updated_at

    # FIXME the create action on the Task resource does a POST to
    # https://api.freeagent.com/v2/tasks?project=:project which is
    # inconsistent with the rest of the API. 
    def self.create(attributes = {})
      raise FreeAgent::NotImplemented.new("Opps creating tasks not implemented - see source for details")
    end

    def self.find_by_project(project)
      Task.filter(:project => project)
    end
  end
end