module CitiesRepository
  extend ActiveSupport::Concern

  included do
    include UsefullScopes

    scope :cities_to_go, ->(id) { where("id <> ?", id) }
  end
end
