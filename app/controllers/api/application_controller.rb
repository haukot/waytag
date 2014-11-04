class Api::ApplicationController < ApplicationController
  respond_to :json
  layout false

  include Api::Auth
  include CorsController

  before_action :authenticate_user!
end
