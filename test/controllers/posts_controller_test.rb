require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = create :post
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    post :create, post: { content: @post.content, published_at: @post.published_at, seo_description: @post.seo_description, seo_keywords: @post.seo_keywords, seo_name: @post.seo_name, state: @post.state, title: @post.title, user_name: @post.user_name }

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { content: @post.content, published_at: @post.published_at, seo_description: @post.seo_description, seo_keywords: @post.seo_keywords, seo_name: @post.seo_name, state: @post.state, title: @post.title, user_name: @post.user_name }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    delete :destroy, id: @post

    assert_redirected_to posts_path
  end
end
