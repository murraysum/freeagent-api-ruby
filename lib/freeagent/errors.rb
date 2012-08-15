require 'multi_json'

module FreeAgent
  class ApiError < StandardError
    attr_reader :response, :status, :errors

    def initialize(response)
      @response = response
      @status = response.status
      @errors = MultiJson.decode(response.body) rescue nil
    end

    def to_s
      inspect
    end

    def inspect
      "#<#{self.class}: response: #{response}, status: #{status}, errors: #{errors} >"
    end
  end

  class ClientError < StandardError
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def to_s
      # TODO
    end

    def inspect
      # TODO
    end
  end

  class NotImplemented < StandardError
    attr_reader :message

    def initialized(message)
      @message = message
    end

    def to_s
      message
    end

    def inspect
      "#<#{self.class}: message: #{message} >"
    end
  end
end
