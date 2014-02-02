class PushWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  def perform(report_id)
    report = Report.find report_id
    UrbanairshipService.push(report)
  end
end
