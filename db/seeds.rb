# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(name: 'Jesse Sessler', admin: true)
  User.create(name: 'Jesse Sessler',
              email: 'jesse.sessler@gmail.com',
              admin: true,
              zip_code: 10065,
              password: 'jessesessler',
              password_confirmation: 'jessesessler')
end
