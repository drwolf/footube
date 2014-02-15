# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! username: 'foo', email: 'foo@example.com', password: 'test1234'

100.times do
  video = Video.create user: user, title: 'My first video', description: 'blah blah blah ...'
  video.processed = true
  video.save
  version = video.versions.create resolution: '320x200'
  version.progress = 100.0
  version.processed = true
  version.save
end