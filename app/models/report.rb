# encoding: utf-8

class Report < ActiveRecord::Base
  include EventKindable
  include TextFunctions
  include GeoFunctions

  belongs_to :city
  belongs_to :sourceable, polymorphic: true

  enumerize :source_kind, in: [:web, :api, :ios, :android, :mentions, :hashtag, :vk]

  validates :time, presence: true
  validates :source_kind, presence: true
  validates :city, presence: true

  state_machine :state, initial: :added do
    state :added
    state :deleted
    state :posted
    state :rejected
    state :bad
    state :wating_post
    state :post_failed

    event :post do
      transition :wating_post => :posted
    end

    event :approve do
      transition all => :wating_post
    end

    event :mark_as_bad do
      transition :added => :bad
    end

    event :reject do
      transition all => :rejected
      transition :wating_post => :post_failed
    end

    event :safe_delete do
      transition all => :deleted
    end
  end

  before_save :define_event_kind

  include ReportsRepository

  def contains_bad_data?
    super || with_mentions? || less_three_words? || has_obscenity?
  end

  def has_obscenity?
    RussianObscenity.obscene?(clean_text)
  end

  def less_three_words?
    clean_text.split.size < 3
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

  def clean_text
    text.gsub(/(#{city.twitter_name}|#{city.hashtag})/i, '')
    .sub(/\A\[\d{1,2}:\d{1,2}\]/, '')
    .gsub(/via\s.*$/, '')
    .gsub(/#.*?(\s|$)/, ' ')
    .gsub(/\s+/, ' ')
    .strip
  end

  def text_without_via
    clean_text.gsub(/via\s.*$/, '')
    .strip
  end

  def safe_text
    if Rails.env.staging? || Rails.env.development?
      text.gsub(/@|#/, '')
    else
      text
    end
  end

  def has_duplicate?
    self.class.where("(time > ?) AND (text LIKE ? OR source_text LIKE ?) AND (id != ?)", time - 2.hours, "%#{text}%", "%#{source_text}%", id).any?
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

  def self.states
    state_machine.states.map{|s| s.name}
  end

  def text_empty?
    source_text.nil? || source_text.empty?
  end

  def define_event_kind
    self.event_kind ||= EventKinds.from_text(source_text)
  end

end
