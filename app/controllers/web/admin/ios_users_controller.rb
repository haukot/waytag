class Web::Admin::IosUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_ios_user, except: [:index, :on, :off]

  def index
    query = params[:q] || {}
    @search = IosUser.ransack query
    @ios_users = @search.result.page(params[:page]).decorate
  end

  def destroy
    @ios_user.destroy
    f(:success)
    redirect_to admin_ios_users_url
  end

  private
    def set_ios_user
      @ios_user = IosUser.find(params[:id])
    end

    def sourceable
      @sourceable = IosUser.find params[:ios_user_id]
    end
end
