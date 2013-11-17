class Api::Cities::ApplicationController < Api::ApplicationController
  def resource_city
    @resource_city ||= City.friendly.find params[:city_id]
  end
end
