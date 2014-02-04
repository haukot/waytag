class Web::Cities::ReportsController < Web::Cities::ApplicationController

  def create
    report = Web::ReportType.new(report_params)
    report.city = resource_city
    report.sourceable = WebUser.find_or_create_by(ip: request.remote_ip)
    report.source_kind = :web

    if report.save
      ReportsWorker.perform_async(report.id)
      session[:latest_posted_at] = Time.now + 5.minutes

      render nothing: true, status: :created
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report)
  end

end
