module Auth
  class TokenProvider
    ALGORITHM = "HS256"
    HMAC_SECRET = ENV.fetch("HMAC_SECRET", "TODO:FIXME")

    def initialize(pepper)
      @pepper = pepper
    end

    def generate(payload = {})
      JWT.encode(payload.merge(required_options), HMAC_SECRET + @pepper, ALGORITHM)
    end

    def valid?(token)
      JWT.decode(token, HMAC_SECRET + @pepper, true, algorithm: ALGORITHM)
    rescue JWT::DecodeError
      false
    end

    ##
    # +seed+ is needed to randomize tokens over time
    #
    def required_options
      {
        iss: "Digital Papers",
        iat: Time.current.to_i,
        nbf: Time.current.to_i,
        exp: Time.current.to_i + 3600 * 24 * 7,
        sub: "Private API Authentication Token",
        seed: SecureRandom.hex(8),
      }
    end
  end
end
