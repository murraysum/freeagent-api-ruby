module FreeAgent
  class User < Resource
    resource :user

    resource_methods :find, :all, :delete, :update, :create

    attr_accessor :first_name, :last_name, :email, :role, :permission_level, :ni_number
    attr_writer :password, :password_confirmation

    decimal_accessor :opening_mileage

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
