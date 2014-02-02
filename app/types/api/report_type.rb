class Api::ReportType < Report
  include BaseType

  permit :event_kind, :text, :longitude, :latitude, :accuracy, :time

  validates :event_kind, presence: true
  validate :text_or_geo

  def text_or_geo
    unless text || (latitude && longitude)
      errors.add(:text, "[text] or [latitude] and [longitude] should be present")
      errors.add(:longitude, "[text] or [latitude] and [longitude] should be present")
      errors.add(:latitude, "[text] or [latitude] and [longitude] should be present")
    end
  end

  def initialize(params = {})
    params[:time] = Time.zone.now
    super(params)
  end

end
