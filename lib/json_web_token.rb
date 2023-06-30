class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s # TODO: add rails secret
  EXPIRATION_TIME = 24.hours

  def self.encode(payload, exp = EXPIRATION_TIME)
    payload[:exp] = exp.from_now.to_i

    {
      token: JWT.encode(payload, SECRET_KEY, 'HS256'),
      exp: payload[:exp]
    }
  end

  def self.decode(token)
    decoded_token = JWT.decode token, SECRET_KEY, { algorithm: 'HS256' }
    decoded_token.first.symbolize_keys!
  end
end
