# encoding: UTF-8
#############################
# app.rb
#############################
require 'rubygems'
require 'bundler'
require 'pp'

Bundler.require

require_all 'models', 'controllers', 'lib', 'extensions'

Dotenv.load

module MyApp
  class App < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    use UsersController
  end
end
