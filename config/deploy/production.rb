set :application, 'waytag'

set :rails_env, :production
set :branch, 'master'
set :user, 'waytag_production'
set :keep_releases, 5

role :web, '188.226.206.114'
role :app, '188.226.206.114'
role :db, '188.226.206.114', primary: true
