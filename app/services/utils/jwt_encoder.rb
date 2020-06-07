# frozen_string_literal: true

module Utils
  class JWTEncoder
    HMAC_SECRET = "5d1769586aec7ff0ff65"

    def self.encode(payload)
      JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
      JWT.decode(token, HMAC_SECRET).first
    end
  end
end
