ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'wrong/adapters/minitest'
require 'sidekiq/testing'

Dir[Rails.root.join("test/lib/*.rb")].each {|f| require f}

FactoryGirl.reload
FactoryGirlSequences.reload
Wrong.config.color

Sidekiq::Testing.fake!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include FactoryGirl::Syntax::Methods
end
