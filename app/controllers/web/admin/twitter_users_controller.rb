class Web::Admin::TwitterUsersController < Web::Admin::ApplicationController
  before_action :set_twitter_user, except: :index

  # GET /twitter_users
  def index
    @twitter_users = TwitterUser.all
  end

  # POST /twitter_users
  def create
    TwitterService.populate_user params[:screen_name]
    redirect_to admin_twitter_users_url, notice: 'Twitter user was successfully destroyed.'
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

end
