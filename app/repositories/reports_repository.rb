module ReportsRepository
  extend ActiveSupport::Concern

  included do
    include UsefullScopes

    scope :today_posted_in, ->(city) { where(status: :posted).where(city_id: city.id).where('created_at > ? AND created_at < ?', Date.today.beginning_of_day, Time.now).order('created_at DESC') }
    scope :latest_posted, ->() { where(state: :posted).by_time }
  end
end
