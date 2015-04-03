# encoding: UTF-8
#############################
# controllers/auth_controller.rb
#############################
module MyApp
  class AuthController < ApplicationController
    BASE_URL = '/auth'.freeze

    post BASE_URL + '/?' do
      email = parsed_json_payload['email']
      password = parsed_json_payload['password']

      if user = User.find_by(email: email).try(:authenticate, password)
        json token: Auth.create_token(user)
      else
        handle_unauthorized
      end
    end
  end
end
