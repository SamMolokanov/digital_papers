module Auth
  class Session
    ID_HASH_SALT = "SALT_232fe5452ab0c586"

    attr_reader :digest, :token

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
