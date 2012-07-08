module FreeAgent
  class User < Resource
    resource :user 

    attr_accessor :first_name, :last_name, :email, :role
    attr_writer :permission_level, :password, :password_confirmation

    decimal_accessor :opening_mileage
    integer_accessor :ni_number, :permission_level

    date_accessor :updated_at, :created_at

    def permission
      puts @permission_level
      permissions[@permission_level] if @permission_level 
    end

    def self.me
      User.new(FreeAgent.client.get('users/me')["user"])
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
