class Web::Cities::DashboardController < Web::Cities::ApplicationController
  helper_method :can_post_message?

  def show
    @reports = resource_city.reports.latest_posted.limit(12).includes([:city, :sourceable]).decorate

    @api_report = Web::ReportType.new
    gon.kinds = EventKinds.all.map { |ek| { key: ek, name: t(ek) } }
  end

  def can_post_message?
    return true unless session[:latest_posted_at]

    session[:latest_posted_at] < Time.now
  end

end
