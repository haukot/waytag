# encoding: utf-8
class TwitterBot
  class << self
    YELL = [
      'Не кричи',
      'Воу! Полегче!',
      'Ой, вы забыли выключить CapsLock',
      'ЩТАА?'
    ]
    QUESTION = [
      'Вам тут не справочная!'
    ]

    def handle_status(status)
      status = ActiveSupport::JSON.decode status
      tweet = TweetPopulator.new(status).populate

      city = tweet.city

      return unless city

      client = ServiceLocator.twitter(city.slug)

      if tweet.love?
        client.create_direct_message(status['user']['id'], 'I love you tooo!')
      else
        return unless tweet

        return if tweet.twitter_user.blocked?

        if tweet.contains_bad_data?
          try_answer_on tweet, client
        else
          add_report(tweet, city, tweet.source)
        end
      end
    end

    def try_answer_on(tweet, _client)
      return if Rails.env.staging?

      if tweet.yell?
        # client.update("@#{tweet.twitter_user.screen_name} #{YELL.sample}", in_reply_to_status_id: tweet.id_str.to_i)
      elsif !tweet.more_two_mentions? && tweet.question?
        # client.update("@#{tweet.twitter_user.screen_name} #{QUESTION.sample}", in_reply_to_status_id: tweet.id_str.to_i)
      end
    end

    def add_report(tweet, city, source)
      rp = ReportPopulator.new(source_kind: source,
                               city_id: city.id)

      report = rp.populate_from_twitter(tweet)

      ReportsWorker.perform_async(report.id)
    end
  end
end
