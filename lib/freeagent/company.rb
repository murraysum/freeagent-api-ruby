module FreeAgent
  class Company < Resource
    resource :company

    attr_accessor :name, :subdomain, :type, :currency, :mileage_units,
                  :company_registration_number,:sales_tax_registration_status, :sales_tax_registration_number

    date_accessor :company_start_date, :freeagent_start_date, :first_accounting_year_end

    def self.information
       Company.new(FreeAgent.client.get('company')["company"])
    end

    def self.tax_timeline
        timeline_items = FreeAgent.client.get('company/tax_timeline')["timeline_items"]
        timeline_items.collect { |item| TimelineItem.new(item)}
    end
   end
end