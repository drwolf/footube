# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create username: 'foo', email: 'foo@example.com', password: 'test1234'

Video.create user: user, title: 'My first video', description: 'blah blah blah ...'
Video.create user: user, title: 'My second video', description: 'blah blah blah ...'
Video.create user: user, title: 'My third video', description: 'blah blah blah ...'