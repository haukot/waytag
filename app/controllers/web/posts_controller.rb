class Web::PostsController < Web::ApplicationController
  before_action :set_post, except: :index

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
