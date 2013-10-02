class Web::Cities::ApplicationController < Web::ApplicationController
  def resource_city
    @resource_city ||= City.find params[:city_id]
  end
end
