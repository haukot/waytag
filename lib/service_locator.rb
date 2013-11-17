class ServiceLocator
  class << self
    def twitter_stream(city)
      city = city.to_sym

      @stream_clients ||= {}

      return @stream_clients[city] if @stream_clients.has_key?(city)


      TweetStream.configure do |config|
        config.consumer_key       = configus.twitter[city].consumer_key
        config.oauth_token        = configus.twitter[city].oauth_token
        config.consumer_secret    = configus.twitter[city].consumer_secret
        config.oauth_token_secret = configus.twitter[city].oauth_token_secret
        config.auth_method        = configus.twitter[city].auth_method
      end

      @stream_clients[city] = TweetStream::Client.new
      @stream_clients[city]
    end

    def waytag_twitter
      twitter(:waytag)
    end

    def twitter(city)
      @rest_clients ||= {}

      key = city.to_sym

      @rest_clients[key] ||= Twitter::Client.new(
        :consumer_key =>          configus.twitter[key].consumer_key,
        :consumer_secret =>       configus.twitter[key].consumer_secret,
        :oauth_token =>           configus.twitter[key].oauth_token,
        :oauth_token_secret =>    configus.twitter[key].oauth_token_secret
      )

      @rest_clients[key]
    end
  end
end
