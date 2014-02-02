module Api::Auth

  def signed_in?
    current_user.present?
  end

  def authenticate_user!
    message = "User with token [#{params[:token]}] does not have permissions to access API or not exists"

    raise ApplicationController::Unauthorized, message unless signed_in?

    message = "User with token [#{params[:token]}] is blocked. Contact to support for additional info"

    raise ApplicationController::Forbidden, message if current_user.blocked?
  end

  def current_user
    message = "User [token] wasn't set"
    raise ApplicationController::Unauthorized, message if params[:token].blank?

    @current_user ||= ApiUser.find_by!(token: params[:token])
  end

end
