require 'test_helper'

class Web::Admin::IosUsersControllerTest < ActionController::TestCase
  setup do
    @ios_user = create :ios_user
  end

  test "should patch on" do
    @ios_user.deactivate

    patch :on, ios_user_id: @ios_user
    assert_response :success

    @ios_user.reload
    assert { @ios_user.active? == true}
  end

  test "should patch off" do
    @ios_user.activate

    patch :off, ios_user_id: @ios_user
    assert_response :success

    @ios_user.reload
    assert { @ios_user.blocked? == true}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ios_users)
  end

  test "should destroy ios_user" do
    delete :destroy, id: @ios_user

    assert_redirected_to admin_ios_users_path
  end
end
