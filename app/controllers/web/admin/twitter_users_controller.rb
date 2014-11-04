class Web::Admin::TwitterUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_twitter_user, except: [:index, :create, :on, :off]

  def index
    query = params[:q] || {}
    @search = TwitterUser.ransack query
    @twitter_users = @search.result.page(params[:page]).decorate
  end

  def create
    params.require(:screen_name)
    user = TwitterService.populate_user params[:screen_name]

    if user.persisted?
      f(:success)
    else
      f(:error)
    end

    redirect_to admin_twitter_users_url
  end

  def destroy
    @twitter_user.destroy

    f(:success)

    redirect_to admin_twitter_users_url
  end

  private

  def set_twitter_user
    @twitter_user = TwitterUser.find(params[:id])
  end

  def sourceable
    @sourceable = TwitterUser.find params[:twitter_user_id]
  end
end
