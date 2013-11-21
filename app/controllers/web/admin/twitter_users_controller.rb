class Web::Admin::TwitterUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_twitter_user, except: [:index, :create, :on, :off]

  # GET /twitter_users
  def index
    query = params[:q] || {}
    @search = TwitterUser.ransack query
    @twitter_users = @search.result.page(params[:page]).decorate
  end

  # POST /twitter_users
  def create
    params.require(:screen_name)
    user = TwitterService.populate_user params[:screen_name]

    if user.persisted?
      notice = 'Succesfully created'
    else
      notice = 'Error with twitter'
    end

    redirect_to admin_twitter_users_url, notice: notice
  end

  # DELETE /twitter_users/1
  def destroy
    @twitter_user.destroy

    redirect_to admin_twitter_users_url, notice: 'Twitter user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter_user
      @twitter_user = TwitterUser.find(params[:id])
    end

    def sourceable
      @sourceable = TwitterUser.find params[:twitter_user_id]
    end
end
