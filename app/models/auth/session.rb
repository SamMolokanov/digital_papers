module Auth
  class Session
    ID_HASH_SALT = "SALT_232fe5452ab0c586"

    attr_reader :digest, :token

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
    #
    # Example, existing session:
    #
    #   Auth::Session.new(pepper: "foobar", token: session.token).valid?
    #   # => true
    #
    def initialize(pepper: nil, token: TokenProvider.generate(pepper: pepper))
      @token = token
      @pepper = pepper
      @digest = Digest::MD5.hexdigest(token + ID_HASH_SALT)
    end

    def valid?
      TokenProvider.valid?(@token, @pepper)
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
