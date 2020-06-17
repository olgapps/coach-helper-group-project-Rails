role :app,        %w(trefl.binar.app)
role :web,        %w(trefl.binar.app)
role :db,         %w(trefl.binar.app)
set :application, 'trefl'

server 'trefl.binar.app', user: fetch(:application), roles: %w(web app db), primary: true

set :rails_env,   'production'
set :branch,      'master' # select which branch should be deployed
set :deploy_to,   "/home/#{fetch(:application)}/www/"

set :rvm_ruby_version, '2.6.3@intern2019'	# put Ruby version and gemset name here
# set :rvm_type, :system	# uncomment if you need to choose RVM installation manually
# set :rvm_map_bins, %w(rake gem bundle ruby rails)	# uncomment if you need to specify which commands should be prefixed with RVM

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 10 do
      execute 'sudo systemctl restart $USER-unicorn.service'
    end
  end

  after :publishing, :restart
end