class Report < ActiveRecord::Base
  include ReportsRepository
  extend Enumerize

  belongs_to :city
  belongs_to :sourceable, polymorphic: true

  has_one :tweet, dependent: :destroy

  validates :source_text, presence: true
  validates :time, presence: true
  validates :source_kind, presence: true
  validates :city, presence: true

  enumerize :source_kind, in: [:web, :api, :ios, :android, :mentions, :hashtag]
  enumerize :event_kind, in: [:dps, :dtp, :cmr, :rmnt, :prbk]

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

end
