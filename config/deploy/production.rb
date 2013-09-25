set :application, "waytag"

set :rails_env, :production
set :branch, 'master'
set :user, 'waytag_production'
set :keep_releases, 5

role :web, '37.139.25.30'
role :app, '37.139.25.30'
role :db, '37.139.25.30', :primary => true
