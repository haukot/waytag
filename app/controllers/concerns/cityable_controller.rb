module CityableController
  extend ActiveSupport::Concern

  included do
    helper_method :resource_city

    before_action :define_city_variables
    skip_before_action :redirect_if_city_defined!

    def define_city_variables
      session[:city] = resource_city.slug
      gon.current_city = resource_city

      set_meta_tags title: "#{resource_city.name}. Сейчас на дорогах", reverse: true, keywords: keywords_for_city
    end

    def keywords_for_city
      resource_city.keywords ||= ''
      default_words = [
        resource_city.name, resource_city.hashtag
      ].concat(resource_city.keywords.split(','))
      kw = configus.keywords
      default_words.concat(kw.map { |w| "#{w} #{resource_city.name.downcase}" })
    end
  end
end
