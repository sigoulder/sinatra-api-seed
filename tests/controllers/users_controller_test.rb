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
    @user.destroy
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
end
