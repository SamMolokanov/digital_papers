module Auth
  class Session
    ##
    # Represents a single auth session
    #
    # When generate new session the +pepper+ must be provided, +token+ should be nil.
    # Typically +pepper+ is encrypted password of a User.
    # If a user changes password - it automatically invalidates all saved sessions
    #
    # When restores persisted session, the value for +token+ should be provided.
    # +pepper+ is required to validate the +token+
    #
    # Example, new session:
    #
    #   session = Auth::Session.new(token_provider: Auth::TokenProvider.new("foobar"))
    #   session.token
    #     # => "eyJhbGciOiJIUzI1NiJ9....JWT_token_here"
    #
    # Example, existing session:
    #
    #   Auth::Session.new(token: "eyJhbG...JWT_token_here", token_provider: Auth::TokenProvider.new("foobar")).valid?
    #     # => true
    #
    def initialize(token: nil, token_provider: nil)
      if token.nil? && token_provider.nil?
        raise ArgumentError, "Token and token_provider can not be nil simultaneously!"
      end

      @token = token
      @token_provider = token_provider
    end

    def valid?
      @token_provider.valid?(token)
    end

    def token
      @token ||= @token_provider.generate
    end

    def ==(that)
      to_h == that.to_h
    end

    def to_h
      { "token" => token }
    end
  end
end
