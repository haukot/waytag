# encoding: utf-8
class TwitterBot
  class << self
    def handle_status(status, city, source)
      if status["text"] == "I love @Ulway!"
        ServiceLocator.twitter(city).direct_message_create(status["user"]["id"], "I love you tooo!")
      else
        report = Report.create_from_twitter(status, city, source)
        ReportsWorker.perform_async(report.id)
      end
    end

    def get_geo(status)
      return [] unless status["geo"] || status["geo"]["coordinates"] || status["geo"]["type"] != "Point"

      status["geo"]["coordinates"]
    end

    def more_two_mentions?(status)
      mentions = status["text"].scan(/@\w*/m)
      mentions.count > 1
    end

    def question?(status)
      status["text"].scan('?').any?
    end

    def retweeted?(status)
      status["retweeted_status"] && status["retweeted_status"]["retweeted"] == true || status["text"].include?("RT")
    end

  class << self
    def create_from_twitter(status, city, source)
      city = City.find_by_slug city
      status = ActiveSupport::JSON.decode status

      report = ReportType.new({
        time: status["created_at"].to_time,
        text: status["text"],
        city_slug: city,
        user_name: status["user"]["screen_name"],
        source: source,
        avatar: status["user"]["profile_image_url"]
      })
    end
  end


  end
end
