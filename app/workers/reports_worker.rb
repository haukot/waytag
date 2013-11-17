class ReportsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(report_id)
    ReportsService.perform(report_id)
  end
end
