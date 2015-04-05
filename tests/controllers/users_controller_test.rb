# encoding: UTF-8
#############################
# tests/controllers/users_controller_test.rb
#############################
require_relative '../test_helper'

class MyApp::UsersControllerTest < Minitest::Test
  def setup
    super

    @user = create :user
    @base_url = MyApp::UsersController::BASE_URL
  end

  def test_get_with_id_success
    sign_in @user

    get @base_url + @user.id.to_s

    assert last_response.ok?

    assert_valid_user_response(@user_id)
  end

  def test_get_with_id_not_found
    sign_in @user

    get @base_url + 'foobar'

    assert_not_found
  end

  def test_get_with_id_unauthorized
    get @base_url + 'foobar'

    assert_unauthorized
  end

  def test_create_user_success
    post @base_url, attributes_for(:user).to_json
    assert_equal 201, last_response.status

    parsed_resp = JSON.parse last_response.body

    assert_valid_user_response
  end

  def test_create_user_fail
    post @base_url, {}.to_json
    assert_equal 400, last_response.status

    parsed_resp = JSON.parse last_response.body

    assert_equal ["can't be blank"], parsed_resp['email']
    assert_equal ["can't be blank"], parsed_resp['password']
  end

  private

  def assert_valid_user_response user_id = nil
    parsed_resp = JSON.parse last_response.body

    if user_id
      assert_equal @user.id, parsed_resp['id']
    else
      refute_nil parsed_resp['id'], 'id should be present'
    end

    refute_nil parsed_resp['email'], 'email should be present'
  end
end
