# encoding: UTF-8
#############################
# tests/controllers/users_controller_test.rb
#############################
require_relative '../test_helper'

class MyApp::UsersControllerTest < Minitest::Test
  def setup
    @user = create :user
    @base_url = MyApp::UsersController::BASE_URL
  end

  def teardown
    @user.destroy if @user
  end

  def test_get_with_id_success
    sign_in @user

    get @base_url + '/' + @user.id.to_s
    assert last_response.ok?

    parsed_resp = JSON.parse last_response.body

    assert_equal @user.id, parsed_resp['id']
    assert_equal @user.email, parsed_resp['email']
  end

  def test_get_with_id_not_found
    sign_in @user

    get @base_url + '/' + 'foobar'

    assert_equal 404, last_response.status
    assert_equal 'not found', last_response.body
  end

  def test_create_user_success
    @user.destroy

    post @base_url, attributes_for(:user).to_json
    assert_equal 201, last_response.status

    parsed_resp = JSON.parse last_response.body
    refute_nil parsed_resp['id']
  end

  def test_create_user_fail
    post @base_url, {}.to_json
    assert_equal 400, last_response.status

    parsed_resp = JSON.parse last_response.body

    assert_equal ["can't be blank"], parsed_resp['email']
    assert_equal ["can't be blank"], parsed_resp['password']
  end
end
