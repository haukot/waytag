class PostWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(report_id)
    TwitterService.update(report_id)
  end
end
