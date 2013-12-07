class Web::Cities::DashboardController < Web::Cities::ApplicationController
  helper_method :can_post_message?

  def show
    @city = resource_city
    @reports = @city.reports.latest_posted.limit(20).decorate
    @api_report = ApiReport.new
  end

  def can_post_message?
    return true unless session[:latest_posted_at]

    session[:latest_posted_at] < Time.now
  end

end
