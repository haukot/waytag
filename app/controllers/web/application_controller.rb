class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  before_action :create_token

  def create_token
    return if session.key?(:a)
    session[:a] = SecureRandom.hex(8)
  end
end
