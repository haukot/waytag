require 'test_helper'

class Web::Admin::VkUsersControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: '8xx8ru'
    sign_in user

    @vk_user = create :vk_user
  end

  test 'should patch on' do
    @vk_user.deactivate

    patch :on, vk_user_id: @vk_user
    assert_response :success

    @vk_user.reload
    assert { @vk_user.active? == true }
  end

  test 'should patch off' do
    @vk_user.activate

    patch :off, vk_user_id: @vk_user
    assert_response :success

    @vk_user.reload
    assert { @vk_user.blocked? == true }
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:vk_users)
  end

  test 'should destroy vk_user' do
    delete :destroy, id: @vk_user

    assert_redirected_to admin_vk_users_path
  end
end
