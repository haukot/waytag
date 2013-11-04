require 'sidekiq'
require "eventmachine"
require "active_support"
require "configus"
require "tweetstream"

require File.expand_path("../../lib/configus", __FILE__)

require File.expand_path("../../app/workers/twitter_bot_worker", __FILE__)
require File.expand_path("../../lib/service_locator", __FILE__)
require File.expand_path("../../lib/twitter_reader", __FILE__)

STDOUT.sync = true

$0 = "tweets-reader"

puts "Hello from TwitterReader v2!"

EM.run do
  ARGV.each do |city|
    EM.next_tick do
      TwitterReader.read_from(city)
    end
  end
end
