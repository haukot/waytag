class Web::ReportType < Report
  include BaseType

  permit :event_kind, :text, :longitude, :latitude, :accuracy, :time

  validates :text, presence: true
  validates :sourceable, presence: true
  validate :user_blocked?

  before_save :save_text_as_source

  def save_text_as_source
    self.source_text = self.text
    self.text = ""
  end

  def user_blocked?
    if sourceable.blocked?
      errors.add(text: "You account is blocked!")
    end
  end

end
