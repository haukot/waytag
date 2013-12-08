class Web::Admin::WebUsersController < Web::Admin::ApplicationController
  include SourceableController

  before_action :set_web_user, except: [:index, :on, :off]

  def index
    query = params[:q] || {}
    @search = WebUser.ransack query
    @web_users = @search.result.page(params[:page]).decorate
  end

  def destroy
    @web_user.destroy

    f(:success)

    redirect_to admin_web_users_url
  end

  private
    def set_web_user
      @web_user = WebUser.find(params[:id])
    end

    def sourceable
      @sourceable = WebUser.find params[:web_user_id]
    end
end
