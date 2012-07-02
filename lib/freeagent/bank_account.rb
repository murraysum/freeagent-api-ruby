module FreeAgent
  class BankAccount < Resource
    self.endpoint = 'bank_accounts'

    attr_accessor :path, :opening_balance, :type, :name, :is_personal, :current_balance

    date_accessor :updated_at, :created_at


  end
end
