set :stage, :staging
set :branch, :master

role :app, %w{action@usw1.actionbox.io}
role :web, %w{action@usw1.actionbox.io}
role :db,  %w{action@usw1.actionbox.io}

set :ssh_options, {
  forward_agent: true,
  port: 13309
}
