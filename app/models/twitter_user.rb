class TwitterUser < ActiveRecord::Base
  include Sourceable

  has_many :tweets
end
