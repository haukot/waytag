class Web::Cities::ReportsController < Web::Cities::ApplicationController
  respond_to :json

  def create
    @api_report = ApiReport.new(report_params)
    @api_report.type = :web
    @api_report.token = request.remote_ip

    if @api_report.valid?
      report = ReportPopulator.new.populate_from_api(@api_report, resource_city)
      ReportsWorker.perform_async(report.id)
      session[:latest_posted_at] = Time.now + 5.minutes

      render nothing: true, status: :created
    else
      respond_with @api_report
    end
  end

  private

    def report_params
      params.require(:api_report).permit(:text, :time, :event_kind)
    end
end
