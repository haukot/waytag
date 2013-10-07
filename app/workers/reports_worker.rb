class ReportsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 1

  def perform(report_id)
    ReportsService.perform(report_id)
  end
end
