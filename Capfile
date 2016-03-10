# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano-resque'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    set :database_username do
      "deploy"
    end

    set :app_name do
      "resque_demo"
    end

    set :database_password do
      Capistrano::CLI.password_prompt "Database Password: "
    end

    db_config = <<-EOF
      base: &base
        adapter: postgresql
        encoding: utf8
        reconnect: false
        pool: 5
        username: #{database_username}
        password: #{database_password}

      development:
        database: #{app_name}_development
        <<: *base

      test:
        database: #{app_name}_test
        <<: *base

      staging:
        database: #{app_name}_production
        <<: *base
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/mongoid.yml #{current_path}/config/mongoid.yml"
  end
end
