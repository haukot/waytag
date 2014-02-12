web:    bundle exec unicorn_rails
worker: bundle exec sidekiq
worker: ruby daemons/twitter_listener.rb ul
worker: ruby daemons/vk_reader.rb
