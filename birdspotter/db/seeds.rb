# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(username: "info@webbteknik.se", password: "hejsanhoppsan", password_confirmation: "hejsanhoppsan")
user2 = User.create(username: "info@aspnet.com", password: "jättetråkigt", password_confirmation: "jättetråkigt")
user3= User.create(username: "js@phpfan.se", password: "loveit", password_confirmation: "loveit", admin:true)

user1.applications << Application.create(application_key: "kjasgfuegfugfjbvnbhvdg6762811ghjfew", application_name: "minfantastiskaapp")
user2.applications << Application.create(application_key: "qkOE2IU484IHRWJKRAJFABJ754FBZKVDGFJ", application_name: "minmindrefantastiskaapp")
user3.applications << Application.create(application_key: "qkOE2IU484IHRWJKRAafdqrtdwd2e142eqr", application_name: "superappen")