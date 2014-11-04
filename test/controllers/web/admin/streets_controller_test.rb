require 'test_helper'

class Web::Admin::StreetsControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: '8xx8ru'
    sign_in user

    @city_street = create 'city/street'
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:city_streets)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create city_street' do
    post :create, city_street: { name: generate(:name) }

    assert_redirected_to admin_streets_path
  end

  test 'should get edit' do
    get :edit, id: @city_street
    assert_response :success
  end

  test 'should update city_street' do
    patch :update, id: @city_street, city_street: { name: generate(:name) }
    assert_redirected_to admin_streets_path
  end

  test 'should destroy city_street' do
    delete :destroy, id: @city_street

    assert_redirected_to admin_streets_path
  end
end
