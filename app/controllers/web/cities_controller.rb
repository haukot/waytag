class Web::CitiesController < Web::ApplicationController
  before_filter :redirect_if_city_defined!

  def index
    @cities = City.all
  end

  def redirect_if_city_defined!
    if session[:city]
      city = City.find session[:city]
      redirect_to city_path(city) if city
    end
  end
end
