module Auth
  class Session
    attr_reader :token

    def initialize(token:)
      @token = token
    end

    def ==(that)
      to_h == that.to_h
    end

    def to_h
      { "token" => token }
    end
  end
end
