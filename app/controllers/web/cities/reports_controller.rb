class Web::Cities::ReportsController < Web::Cities::ApplicationController
  def index
    @reports = resource_city.reports.latest_posted
  end
end
