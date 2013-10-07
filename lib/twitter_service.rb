# encoding: utf-8
class TwitterService
  class << self
    def destroy(report)
      if report.tweet
        c = client(report.city)
        c.status_destroy(report.tweet.id)
      end
    rescue Twitter::Error => e
      Rails.logger.fatal "Twitter error #{e.to_s}"
    end

    def update(report)
      c = client(report.city)

      if report.map_picture
        image =  open(report.map_picture)
        response = client.update_with_media(report.text, image)
      else
        response = client.update(report.text)
      end

      create_tweet(report, response)
    rescue Twitter::Error::Forbidden => e
      Rails.logger.fatal "Tweet rejected #{e.to_s}"
      nil
    end

    private

    def create_tweet(report, response)
      report.tweet.create_from_twitter_response(response)
    end

    def client(city)
      ServiceLocator.twitter(city.slug)
    end
  end
end
