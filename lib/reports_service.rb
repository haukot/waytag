class ReportsService
  class << self
    def destroy(report)
      TwitterService.destroy(report) if report.id_str
      report.safe_delete
    end

    def perform(report_id)
      approve_text = false
      report = Report.find report_id

      if report.text_empty?
        report.generate_text_by_geo
        approve_text = true
      end

      return report.reject if report.text_empty?

      report.text = TextComposer.compose(report)

      return report.destroy if report.has_duplicate?

      if approve_text
        report.approve
      else
        report.try_approve!
      end

      report.save!

      if report.wating_post?
        PostWorker.perform_async(report.id)
      end
    end

  end
end
