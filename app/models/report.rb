# encoding: utf-8

class Report < ActiveRecord::Base
  include ReportsRepository
  include TextFunctions

  extend Enumerize

  belongs_to :city
  belongs_to :sourceable, polymorphic: true

  has_one :tweet, dependent: :destroy

  validates :source_text, presence: true
  validates :time, presence: true
  validates :source_kind, presence: true
  validates :city, presence: true

  enumerize :source_kind, in: [:web, :api, :ios, :android, :mentions, :hashtag]
  enumerize :event_kind, in: EventKinds.all
  enumerize :reject_kind, in: [:unknown_classify, :spam, :question, :yell, :reply]

  state_machine :state, initial: :added do
    after_transition any => :rejected, do: :set_reject_kind

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

  private

  def set_reject_kind
    if question?
      self.reject_kind = :question
    elsif yell?
      self.reject_kind = :yell
    elsif with_mentions?
      self.reject_kind = :reply
    else
      if bayes == Classifier::UNKNOWN
        self.reject_kind = :unknown_classify
      elsif bayes == Classifier::BAD
        self.reject_kind = :spam
      end
    end
  end
end
