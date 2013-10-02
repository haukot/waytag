class City < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, :use => :slugged

  has_many :reports
  has_many :bonuses
  has_many :partners
  has_many :streets

end
