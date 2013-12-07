class Web::Admin::ApplicationController < Web::ApplicationController
  include AuthHelper

  before_filter :authenticate_user!
  before_filter :authorize_user!
  skip_before_filter :redirect_if_city_defined!

  helper_method :current_user, :signed_in?
end
