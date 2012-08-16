module FreeAgent
  class BankAccount < Resource
    resource :bank_account

    resource_methods :default

    attr_accessor :type, :name, :is_personal, :account_number, :sort_code, :secondary_sort_code, :iban, :bic, :email

    decimal_accessor :opening_balance, :current_balance

    date_accessor :created_at, :updated_at

    def self.standard_bank_accounts
      BankAccount.filter(:view => "standard_bank_accounts")
    end

    def self.credit_card_accounts
      BankAccount.filter(:view => "credit_card_accounts")
    end

    def self.paypal_accounts
      BankAccount.filter(:view => "paypal_accounts")
    end
  end
end