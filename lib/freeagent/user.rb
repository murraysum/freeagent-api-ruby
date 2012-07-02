module FreeAgent
  class User < Resource
    resource :user 

    attr_accessor :first_name, :last_name, :email, :role, :opening_mileage
    attr_writer :permission_level, :password, :password_confirmation, :ni_number

    date_reader :updated_at, :created_at

    def permission_level
      @permissions[@permisison_level] if @permission_level 
    end

    def self.me
      # TODO 
    end

    private

    def permissions
      ['No Access',
       'Time',
       'My Money',
       'Contacts & Projects',
       'Invoices, Estimates & Files',
       'Bills',
       'Banking',
       'Tax, Accounting & Users',
       'Full']
    end
  end
end
