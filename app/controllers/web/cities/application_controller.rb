class Web::Cities::ApplicationController < Web::ApplicationController
  def resource_city
    @resource_city ||= City.friendly.find params[:city_id]
  end
end
