class Web::PostsController < Web::ApplicationController
  before_action :set_post, except: :index

  # GET /posts
  def index
    query = params[:q] || {}
    @search = Post.by_published_at.ransack(query)
    @posts = @search.result.page(params[:page])
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end
end
