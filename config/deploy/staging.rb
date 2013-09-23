set :stage, :staging
set :rails_env, :staging
set :branch, 'staging'
set :user, 'waytag_staging'
set :keep_releases, 5

role :web, '37.139.25.30'
role :app, '37.139.25.30'
role :db, '37.139.25.30', :primary => true

set :deploy_to, '/u/apps/waytag_staging'
