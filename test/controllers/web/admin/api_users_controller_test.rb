require 'test_helper'

class Web::Admin::ApiUsersControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: '8xx8ru'
    sign_in user

    @api_user = create :api_user
  end

  test 'should patch on' do
    @api_user.deactivate

    patch :on, api_user_id: @api_user
    assert_response :success

    @api_user.reload
    assert { @api_user.active? == true }
  end

  test 'should patch off' do
    @api_user.activate

    patch :off, api_user_id: @api_user
    assert_response :success

    @api_user.reload
    assert { @api_user.blocked? == true }
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_users)
  end

  test 'should destroy api_user' do
    delete :destroy, id: @api_user

    assert_redirected_to admin_api_users_path
  end
end
