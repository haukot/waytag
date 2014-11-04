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
      transition wating_post: :posted
    end

    event :approve do
      transition all => :wating_post
    end

    event :mark_as_bad do
      transition added: :bad
    end

    event :reject do
      transition all => :rejected
      transition wating_post: :post_failed
    end

    event :safe_delete do
      transition all => :deleted
    end
  end

  before_save :define_event_kind

  include ReportsRepository

  def contains_bad_data?
    super || with_mentions? || less_three_words? || obscenity?
  end

  def obscenity?
    RussianObscenity.obscene?(text)
  end

  def less_three_words?
    text.split.size < 3
  end

  def with_mentions?
    mentions = text.scan(/@\w*/m)
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
    Classifier.classify(text).to_sym
  end

  def duplicate?
    self.class.duplicate(self).any?
  end

  def text_empty?
    source_text.nil? || source_text.empty?
  end

  def define_event_kind
    self.event_kind ||= EventKinds.from_text(source_text)
  end
end
