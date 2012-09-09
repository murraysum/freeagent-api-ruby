class BankTransaction < Resource
  resource :bank_transaction

  resource_methods :find, :filter 

  def self.find_all_by_bank_account(bank_account)
    BankTransaction.filter(:bank_account => bank_account) 
  end

  def self.unexplained(bank_account)
    BankTransaction.filter(:view => 'unexplained', :bank_account => bank_account)
  end

  def self.manual(bank_account)
    BankTransaction.filter(:view => 'manual', :bank_account => bank_account)
  end

  def self.imported(bank_account)
    BankTransaction.filter(:view => 'imported', :bank_account => bank_account)
  end
end