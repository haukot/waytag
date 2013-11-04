# encoding: utf-8

class Tweet < ActiveRecord::Base
  include TextFunctions

  belongs_to :report
  belongs_to :twitter_user

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

end
