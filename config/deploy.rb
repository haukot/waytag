set :rake, "#{rake} --trace"

set :stages, %w(staging production)
set :default_stage, "production"
set :rvm_type, :system
set :use_sudo, false
set :ssh_options, :forward_agent => true
default_run_options[:pty] = true

set :repository, 'git@bitbucket.org:8xx8/waytag-web.git'
set :format, :pretty

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{release_path}/config/database.sample.yml #{release_path}/config/database.yml"
  end
end

before 'deploy:finalize_update', 'deploy:symlink_db'
after 'deploy:restart', 'unicorn:stop'
after "deploy:update", "deploy:cleanup"
