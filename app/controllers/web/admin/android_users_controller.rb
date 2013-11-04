class Web::Admin::AndroidUsersController < Web::Admin::ApplicationController
  before_action :set_android_user, except: :index

  # GET /android_users
  def index
    @android_users = AndroidUser.all
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
end
