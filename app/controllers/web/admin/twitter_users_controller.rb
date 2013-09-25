class Web::Admin::TwitterUsersController < Web::Admin::ApplicationController
  before_action :set_twitter_user, except: :index

  # GET /twitter_users
  def index
    @twitter_users = TwitterUser.all
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

    # Only allow a trusted parameter "white list" through.
    def twitter_user_params
      params.require(:twitter_user).permit(:image, :name, :screen_name, :external_id_str, :state)
    end
end