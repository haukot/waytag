require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  setup do
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

    assert_redirected_to city_path(assigns(:city))
  end

  test "should show city" do
    get :show, id: @city
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city
    assert_response :success
  end

  test "should update city" do
    patch :update, id: @city, city: { email: @city.email, hashtag: @city.hashtag, name: @city.name, slug: @city.slug, twitter_name: @city.twitter_name }
    assert_redirected_to city_path(assigns(:city))
  end

  test "should destroy city" do
    delete :destroy, id: @city

    assert_redirected_to cities_path
  end
end
