require 'test_helper'

class Web::Admin::ApiUsersControllerTest < ActionController::TestCase
  setup do
    @api_user = create :api_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_users)
  end

  test "should destroy api_user" do
    delete :destroy, id: @api_user

    assert_redirected_to admin_api_users_path
  end
end
