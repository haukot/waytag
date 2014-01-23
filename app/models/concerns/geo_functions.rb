# encoding: utf-8

module GeoFunctions

  def has_geo?
    latitude && longitude
  end

  def map_picture
    if latitude && longitude
      URI::encode("http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=400x400&markers=color:red|label:O|#{latitude},#{longitude}&sensor=true")
    end
  end

  def generate_text_by_geo
    return unless event_kind
    return unless has_geo?

    results = Geocoder.search("#{latitude}, #{longitude}")

    if results.any?
      result = results.first
      city_name = result.city

      if City.where(name: city_name).any? && result.street_address
        self.source_text = I18n.t(self.event_kind) + " "
        self.source_text += result.street_address.gsub(/\s*\d+\s*/, "")
        self.source_text += ", #{result.street_number}" if result.street_number
      end
    end
  end

  def generate_text_by_geo!
    generate_text_by_geo
    save
  end

  def generate_geo_by_text(report)
    return if has_geo?
    # Бля я не знаю как это сделать но это нам охуеть как надо
  end

end
