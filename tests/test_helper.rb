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
require 'database_cleaner'

require_relative '../app.rb'
require_all 'tests/modules', 'tests/factories'

include Rack::Test::Methods
include FactoryGirl::Syntax::Methods

def app; MyApp::App.new; end

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with :truncation

Minitest.after_run {
  DatabaseCleaner.clean_with :truncation
}

Kernel.silence_warnings {
  BCrypt::Engine::DEFAULT_COST = 1
}

class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def sign_in user
    Auth.stubs(:parse_token).returns(user.id)
  end

  def assert_not_found
    assert_equal 404, last_response.status
    assert_equal 'not found', last_response.body
  end

  def assert_unauthorized
    assert_equal 403, last_response.status
    assert_match 'unauthorized', last_response.body
  end
end
