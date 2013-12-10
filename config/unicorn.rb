project_home = ENV['UNICORN_HOME'] || '.'
working_directory project_home

worker_processes (ENV['UNICORN_WORKERS'] || 1).to_i

listen ENV['APP_ROOT'] + "/shared/.sock", :backlog => 64
timeout (ENV['UNICORN_TIMEOUT'] || 60).to_i

pid ENV['APP_ROOT'] + "/shared/pids/unicorn.pid"

# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  #GC.disable
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
