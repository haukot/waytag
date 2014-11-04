class Web::CitiesController < Web::ApplicationController
  before_action :redirect_if_city_defined!

  def index
    @cities = City.all
  end

  private

  def redirect_if_city_defined!
    return unless session[:city]
    city = City.friendly.find session[:city]
    redirect_to city_path(city) if city
  end
end
