# encoding: UTF-8
#############################
# tests/models/user_test.rb
#############################
require_relative '../test_helper'

class MyApp::UserTest < Minitest::Test
  include ModelTests

  def setup
    @model = build :user
  end
end
