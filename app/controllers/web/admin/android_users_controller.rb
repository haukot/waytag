class Web::Admin::AndroidUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_android_user, except: [:index, :on, :off]

  def index
    query = params[:q] || {}
    @search = AndroidUser.ransack query
    @android_users = @search.result.page(params[:page]).decorate
  end

  def destroy
    @android_user.destroy

    f(:success)
    redirect_to admin_android_users_url
  end

  private
    def set_android_user
      @android_user = AndroidUser.find(params[:id])
    end

    def sourceable
      @sourceable = AndroidUser.find params[:android_user_id]
    end
end
