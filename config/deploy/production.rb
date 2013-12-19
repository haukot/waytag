set :application, "waytag"

set :rails_env, :production
set :branch, 'master'
set :user, 'waytag_production'
set :keep_releases, 5

role :web, '95.85.39.207'
role :app, '95.85.39.207'
role :db, '95.85.39.207', :primary => true
