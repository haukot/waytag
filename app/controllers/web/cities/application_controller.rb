class Web::Cities::ApplicationController < Web::ApplicationController

  include CityableController

  def resource_city
    @resource_city ||= City.friendly.find(params[:city_id])
  end
end
