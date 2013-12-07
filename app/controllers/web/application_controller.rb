class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  before_filter :redirect_if_city_defined!
  before_filter :create_token

  def create_token
    return if session.has_key?(:a)
    session[:a] = SecureRandom.hex(8)
  end

  def redirect_if_city_defined!
    if session[:city]
      city = City.friendly.find session[:city]
      redirect_to city_path(city) if city
    end
  end

end
