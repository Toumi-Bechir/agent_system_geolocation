# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: 'admin')
Role.create(name: 'master')
Role.create(name: 'agent')
Role.create(name: 'subagent')
Role.create(name: 'shop')
Role.create(name: 'guest')
