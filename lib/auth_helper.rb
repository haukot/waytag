module AuthHelper
  # User auth
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def signed_in?
    session[:user_id] && TwitterUser.find_by_id(session[:user_id])
  end

  def authenticate_user!
    redirect_to new_admin_session_path unless signed_in?
  end

  def authorize_user!
    redirect_to root_path unless current_user.admin?
  end

  def current_user
    @current_user ||= TwitterUser.find(session[:user_id])
  end
end
