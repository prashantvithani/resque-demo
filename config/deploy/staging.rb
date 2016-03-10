# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :branch, 'master'
set :stage, :staging
set :deploy_to, "/var/www/resque_demo"
set :bundle_without, %w[test].join(' ')
set :default_env, path: "$PATH:/home/deploy/.rvm/rubies/ruby-2.2.2/bin/ruby"

role :resque_worker, "188.166.247.38"
role :resque_scheduler, "188.166.247.38"

set :workers, { "default_queue" => 2 }
set :resque_environment_task, true
# For some reason, Capistrano does not pick the right staging path
# in deploy.rb. Hence duplicating these lines here.

# Deploying the present branch
def red(str)
  "\e[31m#{str}\e[0m"
end

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# Oldmonk
server '188.166.247.38', user: 'deploy', roles: %w[app db code sidekiq_workers oldmonk]
# Drogon
# server '128.199.97.198', user: 'deploy', roles: %w[web app code drogon]

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
