class City < ActiveRecord::Base
  extend FriendlyId
  include CitiesRepository

  friendly_id :slug, :use => :slugged

  has_many :reports
  has_many :bonuses
  has_many :partners
  has_many :streets

  def cities_to_go
    if id
      self.class.cities_to_go(id)
    else
      self.none
    end
  end

end
