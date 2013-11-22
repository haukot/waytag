set :application, "waytag_staging"

set :rails_env, :staging
set :branch, 'staging'
set :user, 'waytag_staging'
set :keep_releases, 5

role :web, '192.241.206.241'
role :app, '192.241.206.241'
role :db, '192.241.206.241', :primary => true
