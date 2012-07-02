
module FreeAgent
  class ApiError < StandardError
    attr_reader :response, :code

    def initialize(response)
      # TODO
    end

    def to_s
      # TODO
    end

    def inspect
      # TODO
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
end
