module FreeAgent
  class Contact < Resource
    resource :contact

    resource_methods :default

    attr_accessor :first_name, :last_name, :contact_name_on_invoice, :country, :locale, :sales_tax_registration_number, :uses_contact_invoice_sequence

    attr_accessor :organisation_name, :email, :billing_email, :phone_number

    attr_accessor :address1, :town, :region, :postcode, :address2, :address3, :country

    date_accessor :created_at, :updated_at

    decimal_accessor :account_balance

    def self.active
      Contact.filter(:view => 'active')
    end

    def self.clients
      Contact.filter(:view => 'clients')
    end

    def self.suppliers
      Contact.filter(:view => 'suppliers')
    end

    def self.active_projects
      Contact.filter(:view => 'active_projects')
    end

    def self.completed_projects
      Contact.filter(:view => 'completed_projects')
    end

    def self.open_clients
      Contact.filter(:view => 'open_clients')
    end

    def self.open_suppliers
      Contact.filter(:view => 'open_suppliers')
    end

    def self.hidden
      Contact.filter(:view => 'hidden')
    end
  end
end