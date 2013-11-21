OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, configus.twitter.waytag.consumer_key, configus.twitter.waytag.consumer_secret
end

