require 'test_helper'

class Web::Admin::AndroidUsersControllerTest < ActionController::TestCase
  setup do
    @android_user = create :android_user
  end

  test "should patch on" do
    @android_user.deactivate

    patch :on, android_user_id: @android_user
    assert_response :success

    @android_user.reload
    assert { @android_user.active? == true}
  end

  test "should patch off" do
    @android_user.activate

    patch :off, android_user_id: @android_user
    assert_response :success

    @android_user.reload
    assert { @android_user.blocked? == true}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:android_users)
  end

  test "should destroy android_user" do
    delete :destroy, id: @android_user

    assert_redirected_to admin_android_users_path
  end
end
