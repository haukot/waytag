module ReportsRepository
  extend ActiveSupport::Concern

  included do
    include UsefullScopes

    scope :latest_posted, ->() { where(state: :posted).by_time }

    scope :today_posted_in, ->(city) { where(status: :posted).where(city_id: city.id).where('time > ? AND time < ?', Date.today.beginning_of_day, Time.now).order('time DESC') }

    scope :this_year, -> { where("time BETWEEN ? AND ?", Date.today.beginning_of_year, Date.today.end_of_year) }

    scope :dtp, -> { where(event_kind: :dtp) }
    scope :by_month, -> { select("date_trunc('month', time) AS month , count(*) AS count").group('1').order("month") }
    scope :by_day, -> { select("to_char(time, 'D') AS day , count(*) AS count").group('1').order("day") }
    scope :by_hour, -> { select("to_char(time, 'HH24') AS hour , count(*) AS count").group('1').order("hour") }
    scope :in_street, ->(streets) do
      cond = streets.map { |c| "text ILIKE '%#{c}%'" }
      where(cond.join ' OR ')
    end
  end

end
