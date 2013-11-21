class ApiReport
  include ActiveModel::Model
  include EventKindable
  include TextFunctions

  attr_accessor :time, :text, :event_kind, :type, :token, :longitude, :latitude

  enumerize :device_type, in: [:android, :ios, :api]

  validates :text, presence: true
  validates :type, presence: true
  validates :token, presence: true
  validate :sourceable_not_blocked?

  def sourceable_not_blocked?
    if sourceable.blocked?
      errors.add(:token, "You account is blocked!")
    end
  end

  def sourceable
    @sourceable ||= SourceablePopulator.new(device_params).populate
  end

  def to_report_params
    {
      time: time,
      source_kind: type,
      source_text: text,
      sourceable: sourceable,
      longitude: longitude,
      latitude: latitude,
      event_kind: event_kind || EventKinds.from_text(text)
    }
  end

  def device_params
    {
      type: type,
      token: token
    }
  end

end