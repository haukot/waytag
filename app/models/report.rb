# encoding: utf-8

class Report < ActiveRecord::Base
  include EventKindable
  include TextFunctions

  belongs_to :city
  belongs_to :sourceable, polymorphic: true

  validates :source_text, presence: true
  validates :time, presence: true
  validates :source_kind, presence: true
  validates :city, presence: true

  enumerize :source_kind, in: [:web, :api, :ios, :android, :mentions, :hashtag]

  state_machine :state, initial: :added do
    state :added
    state :posted
    state :rejected
    state :bad
    state :wating_post
    state :post_failed

    event :post do
      transition :wating_post => :posted
    end

    event :approve do
      transition [:bad, :added] => :wating_post
    end

    event :mark_as_bad do
      transition :added => :bad
    end

    event :reject do
      transition :added => :rejected
      transition :wating_post => :post_failed
    end
  end

  include ReportsRepository

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
    elsif classify != :good
      mark_as_bad
    else
      approve
    end

    save!
  end

  def classify
    Classifier.classify(clean_text).to_sym
  end

  def map_picture
    if latitude && longitude
      URI::encode("http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=400x400&markers=color:red|label:O|#{latitude},#{longitude}&sensor=true")
    end
  end

  def clean_text
    text.gsub(/(#ulsk|##{city.hashtag}|#{city.twitter_name}|#{city.hashtag})/i, '')
    .sub(/\A\[\d{1,2}:\d{1,2}\]/, '')
    .gsub(/via\s.*$/, '')
    .gsub(/\s+/, ' ')
    .strip
  end

  def text_without_via
    clean_text.gsub(/via\s.*$/, '')
    .strip
  end

  def has_duplicate?
    self.class.where("(time > ?) AND (text = ? OR source_text = ?) AND ( id != ?)", time - 2.hours, text, source_text, id).any?
  end

  def has_userpic?
    sourceable && sourceable.respond_to?(:profile_image_url)
  end

  def userpic
    return sourceable.profile_image_url if has_userpic?
  end

  def has_username?
    sourceable && sourceable.respond_to?(:screen_name)
  end

  def username
    return sourceable.screen_name if has_username?
  end
end
