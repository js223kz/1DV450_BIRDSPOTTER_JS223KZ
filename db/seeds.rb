# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


user1 = User.create(username: "info@webbteknik.se", password: "hejsanhoppsan", password_confirmation: "hejsanhoppsan")
user2 = User.create(username: "info@aspnet.com", password: "jättetråkigt", password_confirmation: "jättetråkigt")
user3= User.create(username: "js@phpfan.se", password: "loveit", password_confirmation: "loveit", admin:true)

user1.apikeys << Apikey.create(application_name: "minfantastiskaapp")
user2.apikeys << Apikey.create(application_name: "minmindrefantastiskaapp")
user3.apikeys << Apikey.create(application_name: "superappen")


bird_spotter1 = Api::V1::Birdspotter.create(user_name: "Marcus", email: "info@marcus.se", password: "hallojsa", password_confirmation:"hallojsa")
bird_spotter2 = Api::V1::Birdspotter.create(user_name: "Szepanski", email: "info@szepanski.se", password: "lösenord", password_confirmation:"lösenord")
bird_spotter3 = Api::V1::Birdspotter.create(user_name: "Johanna", email: "info@superkatten.se", password: "superkatten", password_confirmation:"superkatten")

bird_spotter1.spots << Api::V1::Spot.create(latitude: 55.399771, longitude: 12.869676)
bird_spotter1.spots << Api::V1::Spot.create(latitude: 55.40388, longitude: 12.825587)
bird_spotter2.spots << Api::V1::Spot.create(latitude: 55.408619, longitude: 12.841669)
bird_spotter3.spots << Api::V1::Spot.create(latitude: 55.767888, longitude: 13.518407)

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
Api::V1::Bird.create(bird_name: "Berguv", latin_name: "Bubo bubo", regularity: "B")
Api::V1::Bird.create(bird_name: "Bivråk", latin_name: "Pernis apivorus", regularity: "B")
Api::V1::Bird.create(bird_name: "Biätare", latin_name: "Merops apiaster", regularity: "R")
Api::V1::Bird.create(bird_name: "Björktrast", latin_name: "Turdus pilaris", regularity: "B")
Api::V1::Bird.create(bird_name: "Blå kärrhök", latin_name: "Circus cyaneus", regularity: "B")
Api::V1::Bird.create(bird_name: "Blåhake", latin_name: "Luscinia svecica", regularity: "B")
Api::V1::Bird.create(bird_name: "Blåmes", latin_name: "Parus caeruleus", regularity: "B")
Api::V1::Bird.create(bird_name: "Bläsand", latin_name: "Anas penelope", regularity: "B")
Api::V1::Bird.create(bird_name: "Bläsgås", latin_name: "Anser albifrons", regularity: "M")
Api::V1::Bird.create(bird_name: "Bofink", latin_name: "Fringilla coelebs", regularity: "B")
Api::V1::Bird.create(bird_name: "Brandkronad kungsfågel", latin_name: "Regulus ignicapillus", regularity: "R")
Api::V1::Bird.create(bird_name: "Brednäbbad simsnäppa", latin_name: "Phalaropus fulicarius", regularity: "R")
Api::V1::Bird.create(bird_name: "Bredstjärtad labb", latin_name: "Stercorarius pomarinus", regularity: "R")
Api::V1::Bird.create(bird_name: "Brun glada", latin_name: "Milvus migrans", regularity: "b")
Api::V1::Bird.create(bird_name: "Brun kärrhök", latin_name: "Circus aeruginosus", regularity: "B")
Api::V1::Bird.create(bird_name: "Brunand", latin_name: "Aythya ferina", regularity: "B")
Api::V1::Bird.create(bird_name: "Brushane", latin_name: "Philomachus pugnax", regularity: "B")
Api::V1::Bird.create(bird_name: "Buskskvätta", latin_name: "Saxicola rubetra", regularity: "B")
Api::V1::Bird.create(bird_name: "Busksångare", latin_name: "Acrocephalus dumetorum", regularity: "R")
Api::V1::Bird.create(bird_name: "Bändelkorsnäbb", latin_name: "Loxia leucoptera", regularity: "R")
Api::V1::Bird.create(bird_name: "Citronärla", latin_name: "Motacilla citreola", regularity: "R")
Api::V1::Bird.create(bird_name: "Dalripa", latin_name: "Lagopus lagopus", regularity: "B")
Api::V1::Bird.create(bird_name: "Dammsnäppa", latin_name: "Tringa stagnatilis", regularity: "R")
Api::V1::Bird.create(bird_name: "Domherre", latin_name: "Pyrrhula pyrrhula", regularity: "B")
Api::V1::Bird.create(bird_name: "Drillsnäppa", latin_name: "Actitis hypoleucos", regularity: "B")
Api::V1::Bird.create(bird_name: "Dubbelbeckasin", latin_name: "Gallinago media", regularity: "B")
Api::V1::Bird.create(bird_name: "Dubbeltrast", latin_name: "Turdus viscivorus", regularity: "B")
Api::V1::Bird.create(bird_name: "Duvhök", latin_name: "Accipiter gentilis", regularity: "B")



