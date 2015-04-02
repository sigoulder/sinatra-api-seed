# encoding: UTF-8
#############################
# tests/test_helper.rb
#############################
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'mocha/mini_test'
require 'bcrypt'
require 'require_all'

require_relative '../app.rb'
require_all 'tests/modules', 'tests/factories'

include Rack::Test::Methods
include FactoryGirl::Syntax::Methods

def app; MyApp::App.new; end

Minitest.after_run {
  MyApp::User.destroy_all
}

Kernel.silence_warnings {
  BCrypt::Engine::DEFAULT_COST = 1
}

def sign_in user
  Auth.stubs(:parse_token).returns(user.id)
end
