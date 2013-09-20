class City < ActiveRecord::Base
  has_many :reports
  has_many :bonuses
  has_many :partners

end
