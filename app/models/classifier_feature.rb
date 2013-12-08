class ClassifierFeature < ActiveRecord::Base
  extend Enumerize

  validates :category, presence: true
  validates :name, presence: true, uniqueness: true

  enumerize :category, in: [:good, :bad]
end
