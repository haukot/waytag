# encoding: utf-8

class TweetPopulator < BasePopulator
  permit(:id_str, :retweeted, :text, :in_reply_to_user_id_str, :in_reply_to_status_id_str)

  def create
    tweet = Tweet.new(strong_params)
    tweet.twitter_user = populate_user
    tweet.external_created_at = params["created_at"]

    if geo_data_exists?
      tweet.longitude = params["geo"]["coordinates"].first
      tweet.latitude = params["geo"]["coordinates"].last
    end

    tweet.save ? tweet : nil
  end

  private

  def populate_user
    up = TwitterUserPopulator.new (params["user"])
    up.create
  end

  def geo_data_exists?
    params["geo"] && params["geo"]["coordinates"] && params["geo"]["type"] == "Point"
  end

end
