class Web::Admin::IosUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_ios_user, except: [:index, :on, :off]

  # GET /ios_users
  def index
    query = params[:q] || {}
    @search = IosUser.ransack query
    @ios_users = @search.result.page(params[:page]).decorate
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

    def sourceable
      @sourceable = IosUser.find params[:ios_user_id]
    end
end
