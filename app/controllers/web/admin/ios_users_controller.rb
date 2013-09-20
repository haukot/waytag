class Web::Admin::IosUsersController < Web::Admin::ApplicationController
  before_action :set_ios_user, except: :index

  # GET /ios_users
  def index
    @ios_users = IosUser.all
  end

  # DELETE /ios_users/1
  def destroy
    @ios_user.destroy
    redirect_to admin_ios_users_url, notice: 'Ios user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ios_user
      @ios_user = IosUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ios_user_params
      params.require(:ios_user).permit(:token, :state)
    end
end
