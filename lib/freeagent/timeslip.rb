module FreeAgent
  class Timeslip < Resource
    resource :timeslip

    resource_methods :default

    attr_accessor :user, :project, :task, :comment

    decimal_accessor :hours
    date_accessor :dated_on, :created_at, :updated_at
  end
end