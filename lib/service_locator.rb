class ServiceLocator
  class << self
    def twitter_stream(city)
      city = city.to_sym

      @stream_clients ||= {}

      return @stream_clients[city] if @stream_clients.has_key?(city)

      @stream_clients[city] ||= Twitter::Streaming::Client.new do |config|
        config.consumer_key       = configus.twitter[city].consumer_key
        config.oauth_token        = configus.twitter[city].oauth_token
        config.consumer_secret    = configus.twitter[city].consumer_secret
        config.oauth_token_secret = configus.twitter[city].oauth_token_secret
      end
    end

    def waytag_twitter
      twitter(:waytag)
    end

    def twitter(city)
      @rest_clients ||= {}

      key = city.to_sym

      @rest_clients[key] ||= Twitter::REST::Client.new do |config|
        config.consumer_key =           configus.twitter[key].consumer_key
        config.consumer_secret =        configus.twitter[key].consumer_secret
        config.access_token =           configus.twitter[key].oauth_token
        config.access_token_secret =    configus.twitter[key].oauth_token_secret
      end
    end
  end
end
