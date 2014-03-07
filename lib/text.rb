# encoding: utf-8
class Text
  class << self
    def clean(text)
      cities = City.all

      text.gsub(/@?(#{cities.pluck(:twitter_name).join('|')})/i, '')
      .gsub(/(#{cities.pluck(:hashtag).join('|')})/i, '')
      .gsub(/\[\d{1,2}:\d{1,2}\]/, '')
      .gsub(/via\s.*$/, '')
      .gsub(/#.*?(\s|$)/, ' ')
      .gsub(/\s+/, ' ')
      .strip
    end
  end
end
