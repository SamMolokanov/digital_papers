module Auth
  module TokenProvider
    ALGORITHM = "HS256"
    HMAC_SECRET = ENV.fetch("HMAC_SECRET", "TODO:FIXME")

    module_function

    def generate(payload = {}, pepper:)
      JWT.encode(payload.merge(required_options), HMAC_SECRET + pepper, ALGORITHM)
    end

    def valid?(token, pepper)
      JWT.decode(token, HMAC_SECRET + pepper, true, algorithm: ALGORITHM)
    rescue JWT::DecodeError
      false
    end

    def required_options
      {
        iss: "Digital Papers",
        iat: Time.current.to_i,
        nbf: Time.current.to_i,
        exp: Time.now.to_i + 3600 * 24 * 7,
        sub: "Private API Authentication Token",
        seed: SecureRandom.hex(8),
      }
    end
  end
end
