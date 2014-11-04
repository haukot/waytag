class City::Street < ActiveRecord::Base
  belongs_to :city

  validates :name, presence: true, uniqueness: { scope: :city_id }
end
