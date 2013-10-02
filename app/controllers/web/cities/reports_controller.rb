class Web::Cities::ReportsController < Web::Cities::ApplicationController
  def index
    @reports = resource_city.reports.latest_posted
  end

  def create
    @report = resource_city.reports.build(report_params)
    @report.source_kind = :web

    if @report.save
      ReportsWorker.perform_async('bob', 5)
      redirect_to city_reports_path(resource_city), notice: 'report was successfully created.'
    else
      render action: 'index'
    end
  end

  private

    def report_params
      params.require(:report).permit(:source_text, :time, :event_kind)
    end
end
