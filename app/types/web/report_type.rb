class Web::ReportType < Report
  include BaseType

  permit :event_kind, :text, :longitude, :latitude, :accuracy, :time

  validates :text, presence: true
  validates :sourceable, presence: true
  validate :user_blocked?

  def user_blocked?
    if sourceable.blocked?
      errors.add(text: "You account is blocked!")
    end
  end

end
