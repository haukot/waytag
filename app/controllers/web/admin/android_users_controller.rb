class Web::Admin::AndroidUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_android_user, except: [:index, :on, :off]

  # GET /android_users
  def index
    query = params[:q] || {}
    @search = AndroidUser.ransack query
    @android_users = @search.result.page(params[:page]).decorate
  end

  # DELETE /android_users/1
  def destroy
    @android_user.destroy
    redirect_to admin_android_users_url, notice: 'Android user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_android_user
      @android_user = AndroidUser.find(params[:id])
    end

    def sourceable
      @sourceable = AndroidUser.find params[:android_user_id]
    end
end
