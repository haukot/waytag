require 'test_helper'

class Web::Admin::TwitterUsersControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: "8xx8ru"
    sign_in user

    @twitter_user = create :twitter_user
  end

  test "should patch on" do
    @twitter_user.deactivate

    patch :on, twitter_user_id: @twitter_user
    assert_response :success

    @twitter_user.reload
    assert { @twitter_user.active? == true}
  end

  test "should patch off" do
    @twitter_user.activate

    patch :off, twitter_user_id: @twitter_user
    assert_response :success

    @twitter_user.reload
    assert { @twitter_user.blocked? == true}
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
