class TwitterBotWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(status)
    TwitterBot.handle_status status
  end
end
