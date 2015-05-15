module FreeAgent
  require_relative 'freeagent/client'
  require_relative 'freeagent/errors'

  require_relative 'freeagent/resource'
  require_relative 'freeagent/user'
  require_relative 'freeagent/company'
  require_relative 'freeagent/timeline_item'
  require_relative 'freeagent/attachment'

  require_relative 'freeagent/contact'
  require_relative 'freeagent/project'
  require_relative 'freeagent/task'
  require_relative 'freeagent/timeslip'
  require_relative 'freeagent/note'
  require_relative 'freeagent/recurring_invoice'
  require_relative 'freeagent/invoice'
  require_relative 'freeagent/bank_account'
  require_relative 'freeagent/estimate'
  require_relative 'freeagent/expense'
  require_relative 'freeagent/bank_transaction'
  require_relative 'freeagent/bank_transaction_explanations'
  require_relative 'freeagent/bill'

  class << self
    attr_accessor :environment
    attr_accessor :debug
    attr_reader :client

    def access_details(client_id, client_secret, options = {})
      @client = Client.new(client_id, client_secret)
      @client.refresh_token = options[:refresh_token] if options[:refresh_token]
      @client.access_token = options[:access_token] if options[:access_token]
    end

    def authorize(options)
      @client.authorize(options)
    end
  end
end
