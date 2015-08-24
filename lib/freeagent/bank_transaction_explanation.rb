module FreeAgent
  class BankTransactionExplanation < Resource
    resource :bank_transaction_explanation

    resource_methods :default
    attr_accessor :bank_account, :bank_transaction, :manual_sales_tax_amount, :sales_tax_rate, :description,
      :gross_value, :foreign_currency_value, :rebill_type, :rebill_factor, :category, :paid_invoice,
      :paid_bill, :paid_user, :transfer_bank_account, :asset_life_years, :attachment

    date_accessor :dated_on

    def self.find_all_by_bank_account(bank_account, options = {})
      options.merge!(:bank_account => bank_account)
      BankTransactionExplanation.filter(options)
    end
  end
end
