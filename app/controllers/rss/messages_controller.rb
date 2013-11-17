class Rss::MessagesController < Rss::ApplicationController
  def feed
    @city = City.friendly.find params[:id]
    @messages = @city.reports.latest_posted

    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
end
