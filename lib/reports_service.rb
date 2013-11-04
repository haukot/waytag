class ReportsService
  class << self
    def destroy(report)
      TwitterService.destroy(report) if report.id_str
      report.destroy
    end

    def perform(report_id)
      report = Report.find report_id
      report.text = TextComposer.compose(report)

      report.try_approve!

      if report.wating_post?
        PostWorker.perform_async(report.id)
      end
    end

  end
end
