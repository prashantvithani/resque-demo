# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'resque_demo'
set :repo_url, 'git@github.com:prashantvithani/resque-demo.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/resque_demo'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml config/mongoid.yml]

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Puma stuff
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :puma_worker_timeout, nil
set :puma_role, :web
set :puma_threads, [0, 16]
set :puma_workers, 2
set :puma_init_active_record, true # Change to false when not using ActiveRecord

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :resque_jobs do
  desc 'Enqueue Resque jobs'
  task :start do
    on roles(:app) do
      execute "rake resque_invoke:enqueue_jobs"
    end
  end
end

namespace :mongo do
  desc 'Enqueue Resque jobs'
  task :populate do
    on roles(:app) do
      execute "rake mongo_populate:fill_in"
    end
  end
end
