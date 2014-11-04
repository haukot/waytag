class Web::Admin::PostsController < Web::Admin::ApplicationController
  before_action :set_post, except: [:create, :index, :new]

  def index
    query = params[:q] || {}
    @search = Post.ransack query
    @posts = @search.result.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      f(:success)
      redirect_to admin_posts_path
    else
      f(:error)
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      f(:success)
      redirect_to admin_posts_path
    else
      f(:error)
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    f(:success)
    redirect_to admin_posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_name, :title, :content, :state, :published_at, :seo_name, :seo_keywords, :seo_description)
  end
end
