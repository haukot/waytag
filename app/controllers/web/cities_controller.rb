class Web::CitiesController < Web::ApplicationController
  layout "web/city", only: :show

  before_filter :redirect_if_city_defined!

  def index
    @cities = City.all
  end

  def show
    @city = City.friendly.find params[:id]

    @reports = @city.reports.latest_posted
  end

  def redirect_if_city_defined!
    if session[:city]
      city = City.find session[:city]
      redirect_to city_path(city) if city
    end
  end
end
