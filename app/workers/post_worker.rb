class PostWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(report_id)
    report = Report.find report_id
    TwitterService.update(report)
  end
end
