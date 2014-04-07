# encoding: utf-8

class Tweet
  include ActiveModel::Model
  include TextFunctions

  attr_accessor :id_str, :retweeted, :longitude,
    :latitude, :text, :in_reply_to_status_id_str,
    :in_reply_to_user_id_str, :created_at,
    :twitter_user

  validates :twitter_user, presence: true
  validates :id_str, presence: true
  validates :text, presence: true
  validates :created_at, presence: true

  def city
    return @city if @city

    City.find_each do |city|
      if text.downcase.include?(city.hashtag)
        @city = city
      end
    end

    @city
  end

  def source
    in_reply_to_user_id_str ? :mentions : :hashtag
  end

  def contains_bad_data?
    super || more_two_mentions? || retweeted? || answer?
  end

  def answer?
    in_reply_to_user_id_str || in_reply_to_status_id_str
  end

  def more_two_mentions?
    mentions = text.scan(/@\w*/m)
    mentions.count > 1
  end

  def retweeted?
    retweeted || text.include?("RT")
  end

  def love?
    text == "I love @Ulway!"
  end

end
