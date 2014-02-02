require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  def setup
    @user = create :api_user
  end

  test "should create user" do
    attrs = attributes_for :api_user
    attrs.merge!({ kind: :ios })
    post :create, user: attrs, format: :json

    assert_response :success
  end

  test "should update user" do
    new_token = "ololo"
    patch :update, user: { push_token: new_token }, token: @user.token, format: :json

    assert_response :success

    @user.reload
    assert { @user.push_token == new_token }
  end

end
