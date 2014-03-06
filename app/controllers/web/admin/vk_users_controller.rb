class Web::Admin::VkUsersController < Web::Admin::ApplicationController
  include SourceableController

  def index
    query = params[:q] || {}
    @search = VkUser.ransack query
    @vk_users = @search.result.page(params[:page]).decorate
  end

  def destroy
    @vk_user = VkUser.find(params[:id])
    @vk_user.destroy

    f(:success)

    redirect_to admin_vk_users_url
  end

  private

  def sourceable
    @sourceable = VkUser.find params[:vk_user_id]
  end
end
