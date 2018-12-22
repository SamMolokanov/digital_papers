module Auth
  class Session
    SESSION_SALT = ENV.fetch("SESSION_SALT", "TODO:FIXME SALT_232fe5452ab0c586")

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
    #   session = Auth::Session.new(pepper: "foobar")
    #   session.token
    #     # => "eyJhbGciOiJIUzI1NiJ9....JWT_token_here"
    #
    # Example, existing session:
    #
    #   Auth::Session.new(pepper: "foobar", token: "eyJhbGciOiJIUzI1NiJ9....JWT_token_here").valid?
    #     # => true
    #
    def initialize(pepper: nil, token: nil, token_provider: TokenProvider.new(pepper))
      @token = token
      @token_provider = token_provider
    end

    def valid?
      @token_provider.valid?(token)
    end

    def token
      @token ||= @token_provider.generate
    end

    def digest
      @digest ||= Digest::MD5.hexdigest(token + SESSION_SALT)
    end

    def ==(that)
      to_h == that.to_h
    end

    def to_h
      {
        "digest" => digest,
        "token" => token,
      }
    end
  end
end
