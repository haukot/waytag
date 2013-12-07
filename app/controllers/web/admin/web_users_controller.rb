class Web::Admin::WebUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_web_user, except: [:index, :on, :off]

  # GET /web_users
  def index
    query = params[:q] || {}
    @search = WebUser.ransack query
    @web_users = @search.result.page(params[:page]).decorate
  end

  # DELETE /web_users/1
  def destroy
    @web_user.destroy
    redirect_to admin_web_users_url, notice: 'Web user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_user
      @web_user = WebUser.find(params[:id])
    end

    def sourceable
      @sourceable = WebUser.find params[:web_user_id]
    end
end
