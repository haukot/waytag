module CityableController
  extend ActiveSupport::Concern

  included do
    helper_method :resource_city

    before_action :define_city_variables
    skip_before_action :redirect_if_city_defined!

    def define_city_variables
      session[:city] = resource_city.slug
      gon.current_city = resource_city
    end
  end
end
