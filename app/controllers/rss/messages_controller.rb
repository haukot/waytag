class Rss::MessagesController < Rss::ApplicationController
  def feed
    if params[:token] && params[:token] == "jbyeOOwmpPhTvo7LETJVc3MwgiLYMJS3mvYxZMKC5TgNhteodtH2MBC5ugKBBC6B"
      @city = City.friendly.find params[:id]
      @messages = @city.reports.latest_posted.limit(20).decorate

      render :layout => false
      response.headers["Content-Type"] = "application/xml; charset=utf-8"
    else
      render nothing: true, status: :forbidden
    end
  end
end
