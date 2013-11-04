class TwitterBotWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(status, city, source)
    TwitterBot.handle_status status, city, source
  end
end
