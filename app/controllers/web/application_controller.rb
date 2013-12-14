class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  before_filter :create_token

  def create_token
    return if session.has_key?(:a)
    session[:a] = SecureRandom.hex(8)
  end

end
