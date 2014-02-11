require 'yaml'
APP_CONFIG = YAML.load(File.read(File.expand_path('../app_config.yml', __FILE__)))

SSHKit.config.command_map[:rake] = "bundle exec rake"

set :application, 'footube'
set :repo_url, APP_CONFIG['capistrano']['repo_url']

set :user, APP_CONFIG['capistrano']['user']
set :use_sudo, APP_CONFIG['capistrano']['use_sudo']

set :deploy_to, APP_CONFIG['capistrano']['deploy_to']
set :linked_files, %w(config/mongoid.yml)
set :linked_dirs, (fetch(:linked_dirs) || []) + %w{public/videos private/videos}

set :rvm_ruby_version, 'ruby-2.1.0@footube'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after 'deploy:finishing', 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'

end