# encoding: UTF-8
#############################
# controllers/reminders_controller.rb
#############################
module MyApp
  class UsersController < ApplicationController
    BASE_URL = '/users'.freeze

    get BASE_URL + '/:id/?' do
      authenticate!

      halt 404 unless @current_user.id == params['id'].to_i
      json @current_user
    end

    post BASE_URL + '/?' do
      user = User.new.from_hash parsed_json_payload

      persist user, 201
    end
  end
end
