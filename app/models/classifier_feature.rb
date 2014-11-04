class ClassifierFeature < ActiveRecord::Base
  extend Enumerize

  validates :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :category }

  enumerize :category, in: [:good, :bad]
end
