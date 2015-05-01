module FreeAgent
  class Bill < Resource
    resource :bill

    resource_methods :find, :filter

    attr_accessor :contact, :category, :reference, :status, :attachment
    decimal_accessor :total_value, :paid_value, :due_value, :sales_tax_value, :sales_tax_rate

    date_accessor :dated_on, :due_on

    def attachment
      return nil if @attachment.nil?
      id = extract_id @attachment['url']
      Attachment.find(id)
    end

  end
end
