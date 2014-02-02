class ApiUser < ActiveRecord::Base
  include Sourceable
  include ApiUserRepository
end
