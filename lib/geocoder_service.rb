class GeocoderService
  class << self
    def text_by_geo(report)
      return report unless report.geo?
    end

    def generate_geo_by_text(report)
      return report if report.geo?

      results = Geocoder.search("#{report.latitude}, #{report.longitude}")

      return if results.empty?

      result = results.first
      city_name = result.city

      return unless City.where(name: city_name).any? && result.street_address

      self.text ||= ''
      self.text = kind_to_text(kind)
      self.text += result.street_address.gsub(/\d+\s*/, '')
      self.text += ", #{result.street_number}" if result.street_number

      @geo_data_loaded = true
    end
  end
end
