ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'wrong/adapters/minitest'
require 'sidekiq/testing'
require 'support'

require 'webmock/minitest'

require 'rails/test_help'

FactoryGirl.reload
FactoryGirlSequences.reload
Wrong.config.color

Sidekiq::Testing.fake!

SimpleCov.start 'rails'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include AuthHelper
  include FactoryGirl::Syntax::Methods
  include Wrong
end
