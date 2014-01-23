class GeocoderService
  class << self
    def generate_text_by_geo(report)
      return report unless report.has_geo?

    end

    def generate_geo_by_text(report)
      return report if report.has_geo?

      results = Geocoder.search("#{report.latitude}, #{report.longitude}")

      if results.any?
        result = results.first
        city_name = result.city

        if City.where(name: city_name).any? && result.street_address
          self.text ||= ""
          self.text = kind_to_text(self.kind)
          self.text += result.street_address.gsub(/\d+\s*/, "")
          self.text += ", #{result.street_number}" if result.street_number

          @geo_data_loaded = true
        end
      end

    end

  end
end
