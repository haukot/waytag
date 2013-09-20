require 'test_helper'

class Web::Admin::TwitterUsersControllerTest < ActionController::TestCase
  setup do
    @twitter_user = create :twitter_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitter_users)
  end

  test "should destroy twitter_user" do
    delete :destroy, id: @twitter_user

    assert_redirected_to admin_twitter_users_path
  end
end
