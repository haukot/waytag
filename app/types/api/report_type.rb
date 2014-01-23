class Api::ReportType
  include ActiveModel::Model
  include EventKindable
  include TextFunctions
  include Virtus.model

  attr_accessor :event_kind, :time

  attribute :text, String
  attribute :longitude, Float
  attribute :latitude, Float
  attribute :token, String

  enumerize :from, in: [:android, :ios, :api]

  validates :from, presence: true
  validates :event_kind, presence: true
  validates :token, presence: true
  validate :text_or_geo

  def text_or_geo
    unless text || (latitude && longitude)
      errors.add(:text, "[text] or [latitude] and [longitude] should be present")
      errors.add(:longitude, "[text] or [latitude] and [longitude] should be present")
      errors.add(:latitude, "[text] or [latitude] and [longitude] should be present")
    end
  end

  def sourceable_not_blocked?
    !sourceable.blocked?
  end

  def sourceable
    @sourceable ||= SourceablePopulator.new(device_params).populate
  end

  def to_report_params
    {
      time: Time.zone.now,
      source_kind: from,
      source_text: text,
      sourceable: sourceable,
      longitude: longitude,
      latitude: latitude,
      event_kind: event_kind
    }
  end

  def device_params
    {
      type: from,
      token: token
    }
  end

end
