# encoding: UTF-8
#############################
# controllers/reminders_controller.rb
#############################
module MyApp
  class UsersController < ApplicationController
    BASE_URL = '/users'.freeze

    before BASE_URL + '*' do
      authenticate!
    end

    get BASE_URL + '/:id/?' do
      halt 404 unless @current_user.id == params['id'].to_i
      json @current_user
    end
  end
end
