developer1 = Developer.create(username: "info@webbteknik.se", password: "hejsanhoppsan", password_confirmation: "hejsanhoppsan")
developer2 = Developer.create(username: "info@aspnet.com", password: "jättetråkigt", password_confirmation: "jättetråkigt")
developer3= Developer.create(username: "js@phpfan.se", password: "loveit", password_confirmation: "loveit", admin:true)

developer1.apikeys << Apikey.create(application_key: "kjasgfuegfugfjbvnbhvdg6762811ghjfew", application_name: "minfantastiskaapp")
developer2.apikeys << Apikey.create(application_key: "qkOE2IU484IHRWJKRAJFABJ754FBZKVDGFJ", application_name: "minmindrefantastiskaapp")
developer3.apikeys << Apikey.create(application_key: "qkOE2IU484IHRWJKRAafdqrtdwd2e142eqr", application_name: "superappen")