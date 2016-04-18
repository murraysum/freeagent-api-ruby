module FreeAgent
  class Invoice < Resource
    resource :invoice

    resource_methods :default

    attr_accessor :contact, :reference, :currency, :status, :omit_header, :payment_terms_in_days, :ec_status, :place_of_supply, :invoice_items

    attr_accessor :project, :discount_percent, :written_off_date

    decimal_accessor :exchange_rate, :net_value, :sales_tax_value

    date_accessor :dated_on, :due_on, :paid_on

    # TODO FIXME Need to rename this better
    def self.all_with_nested_items
      Invoice.filter(:nested_invoice_items => true)
    end

    def self.recent_open_or_overdue
      Invoice.filter(:view => 'recent_open_or_overdue')
    end

    def self.open_or_overdue
      Invoice.filter(:view => 'open_or_overdue')
    end

    def self.draft
      Invoice.filter(:view => 'draft')
    end

    def self.scheduled_to_email
      Invoice.filter(:view => 'scheduled_to_email')
    end

    def self.thank_you_emails
      Invoice.filter(:view => 'thank_you_emails')
    end

    def self.reminder_emails
      Invoice.filter(:view => 'reminder_emails')
    end

    def self.last_month(n)
      Invoice.filter(:view => "last_#{n}_months")
    end

    def self.find_all_by_contact(contact)
      Invoice.filter(:contact => contact)
    end

    def self.find_all_by_project(project)
      Invoice.filter(:project => project)
    end
    
    # FIXME Need to figure out the format of the json.
    #def send_email(email)
    #  FreeAgent.client.post("invoices/#{id}/send_email", email)
    #end

    def send_email(from, to, subject, msg)
      FreeAgent.client.post("invoices/#{id}/send_email",{
                  :invoice => {
                    :email => {
                      :to => to,
                      :from => from,
                      :subject => subject,
                      :body => msg
                    } 
              }})
    end

    def mark_as_sent
      FreeAgent.client.put("invoices/#{id}/transitions/mark_as_sent", nil)
    end

    def mark_as_draft
      FreeAgent.client.put("invoices/#{id}/transitions/mark_as_draft", nil)
    end

    def mark_as_cancelled
      FreeAgent.client.put("invoices/#{id}/transitions/mark_as_cancelled", nil)
    end

    # TODO Write invoice timeline wrapper
    #def timeline
    #
    #end
  end
end
