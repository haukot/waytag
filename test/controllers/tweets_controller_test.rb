require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    @tweet = create :tweet
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tweet" do
    post :create, tweet: { id_str: @tweet.id_str, report_id: @tweet.report_id }

    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should show tweet" do
    get :show, id: @tweet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tweet
    assert_response :success
  end

  test "should update tweet" do
    patch :update, id: @tweet, tweet: { id_str: @tweet.id_str, report_id: @tweet.report_id }
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should destroy tweet" do
    delete :destroy, id: @tweet

    assert_redirected_to tweets_path
  end
end
