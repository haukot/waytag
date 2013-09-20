require 'test_helper'

class Web::Admin::TweetsControllerTest < ActionController::TestCase
  setup do
    @tweet = create :tweet
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

end
