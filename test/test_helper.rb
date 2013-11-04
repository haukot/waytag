ENV["RAILS_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'wrong/adapters/minitest'
require 'sidekiq/testing'
require 'support'

FactoryGirl.reload
FactoryGirlSequences.reload
Wrong.config.color

Sidekiq::Testing.fake!

SimpleCov.start 'rails'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include FactoryGirl::Syntax::Methods
  include Wrong
end
