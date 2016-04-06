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

user1.apikeys << Apikey.create(application_name: "minfantastiskaapp")
user2.apikeys << Apikey.create(application_name: "minmindrefantastiskaapp")
user3.apikeys << Apikey.create(application_name: "superappen")


Api::V1::Bird.create(bird_name: "Aftonfalk", latin_name: "Falco vespertinus", regularity: "R")
Api::V1::Bird.create(bird_name: "Alfågel", latin_name: "Clangula hyemalis", regularity: "B")
Api::V1::Bird.create(bird_name: "Alförrädare", latin_name: "Polysticta stelleri", regularity: "R")
Api::V1::Bird.create(bird_name: "Alkekung", latin_name: "Alle alle", regularity: "R")
Api::V1::Bird.create(bird_name: "Amerikansk kopparand", latin_name: "Oxyura jamaicensis", regularity: "b")
Api::V1::Bird.create(bird_name: "Amerikansk kricka", latin_name: "Anas carolinensis", regularity: "R")
Api::V1::Bird.create(bird_name: "Backsvala", latin_name: "Riparia riparia", regularity: "B")
Api::V1::Bird.create(bird_name: "Bergand", latin_name: "Aythya marila", regularity: "B")
Api::V1::Bird.create(bird_name: "Bergfink", latin_name: "Fringilla montifringilla", regularity: "B")
Api::V1::Bird.create(bird_name: "Berglärka", latin_name: "Eremophila alpestris", regularity: "B")


