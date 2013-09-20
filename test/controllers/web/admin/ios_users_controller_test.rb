require 'test_helper'

class Web::Admin::IosUsersControllerTest < ActionController::TestCase
  setup do
    @ios_user = create :ios_user
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
