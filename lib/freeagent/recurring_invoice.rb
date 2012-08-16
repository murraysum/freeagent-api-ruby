module FreeAgent
  class RecurringInvoice < Resource
    resource :recurring_invoice

    resource_methods :all, :filter, :find

    attr_accessor :contact, :frequency, :recurring_status, :reference, :currency, :omit_header, :payment_terms_in_days, :invoice_items

    decimal_accessor :exchange_rate, :net_value, :sales_tax_value, :total_value

    date_accessor :dated_on

    def self.draft
      RecurringInvoice.filter(:view => 'draft')
    end

    def self.active
      RecurringInvoice.filter(:view => 'active')
    end

    def self.inactive
      RecurringInvoice.filter(:view => 'inactive')
    end

    def self.find_all_by_contact(contact)
      RecurringInvoice.filter(:contact => contact)
    end
  end
end