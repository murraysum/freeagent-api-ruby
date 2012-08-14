module FreeAgent
  class Contact < Resource
    resource :contact

    resource_methods :default

    attr_accessor :first_name, :last_name, :contact_name_on_invoice, :country, :locale, :sales_tax_registration_number, :uses_contact_invoice_sequence

    attr_accessor :organisation_name, :email, :phone_number

    attr_accessor :address1, :town, :region, :postcode, :address2, :address3, :country

    date_accessor :created_at, :updated_at

    decimal_accessor :account_balance
  end
end