module FreeAgent
  class Project < Resource
    resource :project

    resource_methods :default

    attr_accessor :name, :contact, :is_ir35, :status, :budget_units, :uses_project_invoice_sequence,
                  :currency, :billing_period, :contract_po_reference

    decimal_accessor :budget, :normal_billing_rate, :hours_per_day

    date_accessor :starts_on, :ends_on, :created_at, :updated_at

    def self.active
      Project.filter(:view => 'active')
    end

    def self.completed
      Project.filter(:view => 'completed')
    end

    def self.cancelled
      Project.filter(:view => 'cancelled')
    end

    def self.hidden
      Project.filter(:view => 'hidden')
    end
  end
end