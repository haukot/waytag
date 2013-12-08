class Web::Admin::SessionsController < Web::Admin::ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  skip_before_filter :authorize_user!, :only => [:new, :create]

  def new
  end

  def create
    user = TwitterUserPopulator.new.populate_from_omniauth(env["omniauth.auth"])
    sign_in user

    redirect_to admin_root_url
  end

  def destroy
    sign_out

    redirect_to root_url
  end
end
