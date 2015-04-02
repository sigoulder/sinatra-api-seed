# encoding: UTF-8
#############################
# lib/auth.rb
#############################
class Auth
  def self.create_token user, expire_days = nil
    expire_days ||= ENV['AUTH_TOKEN_EXPIRE_DAYS']

    payload = { 'sub': user.id,
                'iat': Time.now.to_i,
                'exp': (Time.now + expire_days.to_i.days).to_i }

    JWT.encode(payload, ENV['AUTH_TOKEN_SECRET'])
  end

  def self.parse_token raw
    return nil, 'no token' unless raw

    token = raw.split(' ').last
    return JWT.decode(token, ENV['AUTH_TOKEN_SECRET']).first['sub'], nil
  rescue JWT::DecodeError => error
    return nil, error.message
  end
end
