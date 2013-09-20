class Web::Admin::ApiUsersController < Web::Admin::ApplicationController
  before_action :set_api_user, except: :index

  # GET /api_users
  def index
    @api_users = ApiUser.all
  end

  # DELETE /api_users/1
  def destroy
    @api_user.destroy
    redirect_to admin_api_users_url, notice: 'Api user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_user
      @api_user = ApiUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_user_params
      params.require(:api_user).permit(:token, :state)
    end
end
