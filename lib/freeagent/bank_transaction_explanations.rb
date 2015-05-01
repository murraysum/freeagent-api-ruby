module FreeAgent
  class BankTransactionExplanations < Resource
    resource :bank_transaction_explanation

    resource_methods :find, :filter

    attr_accessor :bank_account, :description, :entry_type, :attachment, :paid_bill
    decimal_accessor :gross_value

    date_accessor :dated_on


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

  end
end
