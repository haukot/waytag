class Web::Admin::ApiUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_api_user, except: [:index, :on, :off]

  # GET /api_users
  def index
    query = params[:q] || {}
    @search = ApiUser.ransack query
    @api_users = @search.result.page(params[:page]).decorate
  end

  # DELETE /api_users/1
  def destroy
    @api_user.destroy

    f(:success)
    redirect_to admin_api_users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_user
      @api_user = ApiUser.find(params[:id])
    end

    def sourceable
      @sourceable = ApiUser.find params[:api_user_id]
    end

end
