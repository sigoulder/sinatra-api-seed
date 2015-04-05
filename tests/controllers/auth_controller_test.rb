# encoding: UTF-8
#############################
# tests/controllers/auth_controller_test.rb
#############################
require_relative '../test_helper'

class MyApp::AuthControllerTest < Minitest::Test
  def setup
    super

    @user = create :user
    @base_url = MyApp::AuthController::BASE_URL

    @payload = { email: @user.email }
  end

  def test_get_token_success
    @payload[:password] = @user.password
    post @base_url, @payload.to_json

    assert last_response.ok?, 'response status should be ok'

    parsed_resp = JSON.parse last_response.body
    refute_nil parsed_resp['token']
  end

  def test_get_token_fail_no_password
    post @base_url, @payload.to_json

    assert_unauthorized
  end

  def test_get_token_fail_wrong_password
    @payload[:password] = @user.password + 'foobar'
    post @base_url, @payload.to_json

    assert_unauthorized
  end
end
