require 'yaml'
APP_CONFIG = YAML.load(File.read(File.expand_path('../app_config.yml', __FILE__)))

SSHKit.config.command_map[:rake] = "bundle exec rake"

set :application, 'footube'
set :repo_url, APP_CONFIG['capistrano']['repo_url']
set :branch, (ENV['BRANCH'] || 'master')

set :user, APP_CONFIG['capistrano']['user']
set :use_sudo, APP_CONFIG['capistrano']['use_sudo']

set :deploy_to, APP_CONFIG['capistrano']['deploy_to']
set :linked_files, %w(config/mongoid.yml config/app_config.yml)
set :linked_dirs, (fetch(:linked_dirs) || []) + %w{public/videos private/videos}

set :rvm_ruby_version, 'ruby-2.1.2@footube'

namespace :deploy do

  after 'deploy:finishing', 'deploy:cleanup'

end
