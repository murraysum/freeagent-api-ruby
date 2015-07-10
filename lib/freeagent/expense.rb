module FreeAgent
  class Expense < Resource
    resource :expense

    resource_methods :default

    attr_accessor :user, :project, :category, :description, :attachment, :recurring

    decimal_accessor :gross_value, :sales_tax_rate, :manual_sales_tax_amount, :mileage, :reclaim_mileage_rate, :rebill_mileage_rate, :rebill_factor

    date_accessor :dated_on, :updated_at, :created_at

    def self.recent
      Expense.filter(:view => 'recent')
    end

    def self.recurring
      Expense.filter(:view => 'recurring')
    end

    def attachment
      return nil if @attachment.nil?
      id = extract_id @attachment['url']
      Attachment.find(id)
    end

    def user
      return nil if @user.nil?
      id = extract_id @user
      User.find(id)
    end

    # TODO Implement this
    #def self.create_batch
    #
    #end
  end
end
