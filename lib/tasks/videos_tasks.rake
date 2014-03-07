namespace :videos do

  desc 'create missing versions for all videos'
  task :create_missing_versions => :environment do
    puts 'creating missing video versions'
    Video.create_missing_versions
    puts 'done'
  end

end