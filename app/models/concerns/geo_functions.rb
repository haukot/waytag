# encoding: utf-8

module GeoFunctions
  def geo?
    latitude && longitude
  end

  def map_picture
    return unless latitude && longitude

    URI.encode("http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=400x400&markers=color:red|label:O|#{latitude},#{longitude}&sensor=true")
  end

  def text_by_geo
    return unless event_kind
    return unless geo?

    results = Geocoder.search("#{latitude}, #{longitude}")

    return if results.empty?

    result = results.first
    city_name = result.city

    return unless City.where(name: city_name).any? && result.street_address

    self.source_text = I18n.t(event_kind) + ' '
    self.source_text += result.street_address.gsub(/\s*\d+\s*/, '')
    self.source_text += ", #{result.street_number}" if result.street_number
  end

  def text_by_geo!
    text_by_geo
    save
  end

  def generate_geo_by_text(_report)
    return if geo?
  end
end
