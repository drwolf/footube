set :stage, :production
set :rails_env, :production

role :app, APP_CONFIG['capistrano']['roles']['production']['app']
role :web, APP_CONFIG['capistrano']['roles']['production']['web']
role :db,  APP_CONFIG['capistrano']['roles']['production']['db']