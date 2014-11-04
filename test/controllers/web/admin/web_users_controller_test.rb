require 'test_helper'

class Web::Admin::WebUsersControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: '8xx8ru'
    sign_in user

    @web_user = create :web_user
  end

  test 'should patch on' do
    @web_user.deactivate

    patch :on, web_user_id: @web_user
    assert_response :success

    @web_user.reload
    assert { @web_user.active? == true }
  end

  test 'should patch off' do
    @web_user.activate

    patch :off, web_user_id: @web_user
    assert_response :success

    @web_user.reload
    assert { @web_user.blocked? == true }
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:web_users)
  end

  test 'should destroy web_user' do
    delete :destroy, id: @web_user

    assert_redirected_to admin_web_users_path
  end
end
