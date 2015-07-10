module FreeAgent
  class Bill < Resource
    resource :bill

    resource_methods :find, :filter

    attr_accessor :contact, :category, :reference, :status, :attachment
    decimal_accessor :total_value, :paid_value, :due_value, :sales_tax_value, :sales_tax_rate

    date_accessor :dated_on, :due_on

    def self.paid_bills
      Bill.filter(:view => "paid")
    end

    def self.open_bills
      Bill.filter(:view => "open")
    end

    def self.overdue_bills
      Bill.filter(:view => "overdue")
    end

    def self.open_or_overdue_bills
      Bill.filter(:view => "open_or_overdue")
    end

    def self.recurring_bills
      Bill.filter(:view => "recurring")
    end

    def attachment
      return nil if @attachment.nil?
      id = extract_id @attachment['url']
      Attachment.find(id)
    end

  end
end
