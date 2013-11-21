class Web::Admin::ApplicationController < Web::ApplicationController
  include AuthHelper

  before_filter :authenticate_user!
  before_filter :authorize_user!
  helper_method :current_user, :signed_in?
end
