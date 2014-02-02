class ApiUser < ActiveRecord::Base
  include Sourceable
  include ApiUserRepository
  extend Enumerize

  enumerize :kind, in: [:android, :ios, :api]

  validates :token, presence: true
  validates :token, uniqueness: true

  validates :kind, presence: true
end
