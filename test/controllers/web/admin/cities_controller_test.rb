require 'test_helper'

class Web::Admin::CitiesControllerTest < ActionController::TestCase
  setup do
    user = create :twitter_user, screen_name: "8xx8ru"
    sign_in user

    @city = create :city
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city" do
    post :create, city: { email: @city.email, hashtag: @city.hashtag, name: @city.name, slug: @city.slug, twitter_name: @city.twitter_name }

    assert_redirected_to admin_cities_path
  end

  test "should get edit" do
    get :edit, id: @city
    assert_response :success
  end

  test "should update city" do
    patch :update, id: @city, city: { email: @city.email, hashtag: @city.hashtag, name: @city.name, slug: @city.slug, twitter_name: @city.twitter_name }
    assert_redirected_to admin_cities_path
  end

  test "should destroy city" do
    delete :destroy, id: @city

    assert_redirected_to admin_cities_path
  end
end
