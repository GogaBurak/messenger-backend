class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s # TODO: add rails secret

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i

    JWT.encode payload, SECRET_KEY, "HS256"
  end

  def self.decode(token)
    decoded_token = JWT.decode token, SECRET_KEY, { algorithm: 'HS256' }
    payload = HashWithIndifferentAccess.new decoded_token.first

    raise JWT::ExpiredSignature unless Time.at(payload[:exp]) >= Time.now

    payload
  end
end
