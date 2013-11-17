# encoding: utf-8

class Report < ActiveRecord::Base
  include ReportsRepository
  include TextFunctions

  extend Enumerize

  belongs_to :city
  belongs_to :sourceable, polymorphic: true

  validates :source_text, presence: true
  validates :time, presence: true
  validates :source_kind, presence: true
  validates :city, presence: true

  enumerize :source_kind, in: [:web, :api, :ios, :android, :mentions, :hashtag]
  enumerize :event_kind, in: EventKinds.all

  state_machine :state, initial: :added do
    state :added
    state :posted
    state :rejected
    state :wating_post
    state :post_failed

    event :post do
      transition [:wating_post] => :posted
    end

    event :approve do
      transition [:added] => :wating_post
    end

    event :reject do
      transition [:added] => :rejected
      transition [:wating_post] => :post_failed
    end
  end

  def contains_bad_data?
    super || with_mentions?
  end

  def with_mentions?
    mentions = clean_text.scan(/@\w*/m)
    mentions.count > 0
  end

  def try_approve!
    if contains_bad_data?
      reject
    elsif classify != Classifier::GOOD
      reject
    else
      approve
    end

    save!
  end

  def classify
    Classifier.classify clean_text
  end

  def map_picture
    if latitude && longitude
      URI::encode("http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=400x400&markers=color:red|label:O|#{latitude},#{longitude}&sensor=true")
    end
  end

  def clean_text
    text.gsub(/(#ulsk|##{city.hashtag}|#{city.twitter_name}|#{city.hashtag})/i, '')
    .sub(/\A\[\d{1,2}:\d{1,2}\]/, '')
    .gsub(/\s+/, ' ')
    .strip
  end

  def text_without_via
    text.gsub(/via\s.*$/, '')
    .strip
  end

end
