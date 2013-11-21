class Web::Cities::ApplicationController < Web::ApplicationController
  helper_method :resource_city

  def resource_city
    @resource_city ||= City.friendly.find params[:city_id]
  end
end
