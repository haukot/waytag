require 'test_helper'

class Web::PostsControllerTest < ActionController::TestCase
  setup do
    @post = create :post
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test 'should get show' do
    get :show, id: @post
    assert_response :success
  end
end
