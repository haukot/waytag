class ReportsService
  class << self
    def destroy(report)
      TwitterService.destroy(report) if report.id_str
      report.reject
    end

    def perform(report_id)
      report = Report.find report_id
      report.text = TextComposer.compose(report)

      if report.has_duplicate?
        return report.destroy
      end

      report.try_approve!

      if report.wating_post?
        PostWorker.perform_async(report.id)
      end
    end

  end
end
