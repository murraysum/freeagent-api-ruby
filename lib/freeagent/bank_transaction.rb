class BankTransaction < Resource
  resource :bank_transaction

  resource_methods :find, :filter 

  def self.find_all_by_bank_account(bank_account, options = {})
    options.merge!(:bank_account => bank_account)
    BankTransaction.filter(options) 
  end

  def self.unexplained(bank_account, options = {})
    options.merge!(:view => 'unexplained', :bank_account => bank_account)
    BankTransaction.filter(options)
  end

  def self.manual(bank_account, options = {})
    options.merge!(:view => 'manual', :bank_account => bank_account)
    BankTransaction.filter(options)
  end

  def self.imported(bank_account, options = {})
    options.merge!(:view => 'imported', :bank_account => bank_account)
    BankTransaction.filter(options)
  end
end