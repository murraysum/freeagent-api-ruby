module FreeAgent
  class BankTransactionExplanation < Resource
    resource :bank_transaction_explanation

    resource_methods :find, :filter

    attr_accessor :bank_account, :description, :entry_type, :attachment, :paid_bill, :paid_invoice, :bank_transaction
    decimal_accessor :gross_value

    date_accessor :dated_on

    def self.find_all_by_bank_account(bank_account, options = {})
      options.merge!(:bank_account => bank_account)
      self.filter(options)
    end

    def attachment
      return nil if @attachment.nil?
      id = extract_id @attachment['url']
      Attachment.find(id)
    end

    def paid_bill
      return nil if @paid_bill.nil?
      id = extract_id @paid_bill
      Bill.find(id)
    end

    def paid_invoice
      return nil if @paid_invoice.nil?

      id = extract_id @paid_invoice
      Invoice.find(id)
    end

    def paid_invoice_id
      return nil if @paid_invoice.nil?

      if @paid_invoice.respond_to?(:id)
        return @paid_invoice.id
      else
        return extract_id(@paid_invoice)
      end
    end

    def bank_transaction
      return nil if @bank_transaction.nil?

      id = extract_id @bank_transaction
      BankTransaction.find(id)
    end
  end
end
