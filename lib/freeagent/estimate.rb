module FreeAgent
  class Estimate < Resource
    resource :estimate

    resource_methods :default

    attr_accessor :contact, :reference, :estimate_type, :status, :currency, :estimate_itmes, :project, :invoice

    decimal_accessor :net_value, :sales_tax_value, :sales_tax_rate, :second_sales_tax_rate

    date_accessor :dated_on, :created_at, :updated_at

    def self.recent
      Estimate.filter(:view => 'recent')
    end

    def self.draft
      Estimate.filter(:view => 'draft')
    end

    def self.non_draft
      Estimate.filter(:view => 'non_draft')
    end

    def self.sent
      Estimate.filter(:view => 'sent')
    end

    def self.approved
      Estimate.filter(:view => 'approved')
    end

    def self.rejected
      Estimate.filter(:view => 'rejected')
    end

    def self.invoiced
      Estimate.filter(:view => 'invoiced')
    end

    def self.find_all_by_contact(contact)
      Estimate.filter(:contact => contact)
    end

    def self.find_all_by_project(project)
      Estimate.filter(:project => project)
    end

    def self.find_all_by_invoice(invoice)
      Estimate.filter(:invoice => invoice)
    end

    def mark_as_sent
      FreeAgent.client.put("estimates/#{id}/transitions/mark_as_sent", nil)
    end

    def mark_as_draft
      FreeAgent.client.put("estimates/#{id}/transitions/mark_as_draft", nil)
    end

    def mark_as_approved
      FreeAgent.client.put("estimates/#{id}/transitions/mark_as_approved", nil)
    end

    def mark_as_rejected
      FreeAgent.client.put("estimates/#{id}/transitions/mark_as_rejected", nil)
    end
  end
end