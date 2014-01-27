class Rss::MessagesController < Rss::ApplicationController
  def feed
    if params["ololo_yeah!"]
      @city = City.friendly.find params[:id]
      @messages = @city.reports.latest_posted.limit(20)

      render :layout => false
      response.headers["Content-Type"] = "application/xml; charset=utf-8"
    else
      render nothing: true, status: :forbidden
    end
  end
end
