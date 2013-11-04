# encoding: utf-8

class TweetPopulator < BasePopulator
  permit(:created_at, :id_str, :retweeted, :text, :in_reply_to_user_id_str, :in_reply_to_status_id_str)

  def populate
    tweet = Tweet.new(strong_params)
    tweet.twitter_user = populate_user

    if geo_data_exists?
      tweet.longitude = params["geo"]["coordinates"].first
      tweet.latitude = params["geo"]["coordinates"].last
    end

    tweet.valid? ? tweet : nil
  end

  private

  def populate_user
    up = TwitterUserPopulator.new (params["user"])
    up.populate
  end

  def geo_data_exists?
    params["geo"] && params["geo"]["coordinates"] && params["geo"]["type"] == "Point"
  end

end
