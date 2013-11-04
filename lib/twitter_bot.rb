# encoding: utf-8
class TwitterBot
  class << self
    def handle_status(status, city, source)
      status = ActiveSupport::JSON.decode status

      if status["text"] == "I love @Ulway!"
        ServiceLocator.twitter(city).direct_message_create(status["user"]["id"], "I love you tooo!")
      else
        tweet = TweetPopulator.new(status).create

        if tweet.contains_bad_data?
          try_answer_on tweet
        else
          add_report(tweet, city, source)
        end
      end
    end

    def try_answer_on(tweet)
    end

    def add_report(tweet, city, source)
      city = City.find_by(slug: city)

      rp = ReportPopulator.new({
        source_kind: source.to_sym,
        city_id: city.id,
      })

      report = rp.create_from_tweet(tweet)

      ReportsWorker.perform_async(report.id)
    end

  end
end
