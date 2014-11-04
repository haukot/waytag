class Web::Admin::ApplicationController < Web::ApplicationController
  include AuthHelper

  before_action :authenticate_user!
  before_action :authorize_user!
  skip_before_action :redirect_if_city_defined!

  helper_method :current_user, :signed_in?
end
