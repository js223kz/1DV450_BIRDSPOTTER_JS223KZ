
# 1DV450_BIRDSPOTTER_JS223KZ
Ett Ruby on Rails/Angular projekt


#### Del I skapa Api-nyckel

**Publicerad applikation:**</br>
https://birdspotterdev.herokuapp.com/

**För att köra applikationen lokalt:**</br>
Kör bundle install för att installera alla gems</br>
  1. Klona repot</br>
  2. rake db:migrate</br>
  3. rake db:setup</br>

**För att testa applikationen som admin**</br>
användarnamn: js@phpfan.se</br>
lösenord: loveit</br>

Registrera dig som användare för att testa applikationen som en "vanlig" användare.


#### Del II använda API:et

**Kort beskrivning:**</br>
API:et innehåller data inrapporterad av fågelskådare. Som användare av API:et går det att få ut en rad olika data:
  
  * Alla fåglar med id, namn, latinskt namn och beteckning för hur vanligt förekommande de är.
    Beteckning över förekomst:
      * arter som regelbundet häckar i Sverige (B)
      * arter vars status som regelbunden häckningsfågel är osäker (b)
      * flyttfåglar som uppträder i Sverige på regelbunden basis (M)
      * tillfälliga gäster som anträffats i mer än 100 exemplar (R)
  * Enskild fågel baserat på fågelns id
  * Fåglar med specifik förekomstbeteckning ex. /birds?regularity=b,R
  * Fågelskådare med id och användarnamn
  * Enskild fågelskådare baserat på fågelskådarens id
  * Alla upptäckter med id, fågelskådarens id, position och fåglar
  * En specifik upptäckt
  * En enskild fågelskådares upptäckter
  * Upptäckter där en specifik fågel ingår
  * Upptäckter i närheten av en specifik position

Den enskilde fågelskådaren kan (fågelskådarens unika token måste skickas med i Headern vid varje request, Authorization Token token=):
  * Rapportera in en upptäckt
  * Ta bort en upptäckt
  * Redigera en upptäckt

För att använda API:et krävs en apinyckel som ska skickas med som en parameter vid varje förfrågan</br> 
tex apiurl/?key=164b564282b60d8f6ef2661d5ad1bb10cbcbbf0dbe093a351de04f4ce4c927b1</br>
Apinycklar går att skapa här: https://birdspotterdev.herokuapp.com/

**Publicerad applikation:**</br>
https://birdspotterdev.herokuapp.com/

**Datbasmodell:**</br>
https://github.com/js223kz/1DV450_BIRDSPOTTER_JS223KZ/wiki

**Testa API:et:**</br>
  1. Installera Chromes plugin Postman: https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop</br>
  3. Importera kollektionen till Postman: https://www.getpostman.com/collections/58893816c2b1a43242e5</br>
  4. Osäker på hur Postman fungerar? Läs mer här: https://www.getpostman.com/docs/blog_mentions

**För att titta på koden**</br>
  1. Klona repot</br>
  2. Kod som rör API:et ligger under namespace app/api/v1</br>

**För att köra applikationen lokalt:**</br>

  1. Klona repot</br>
  2. Kör bundle install för att installera alla gems</br>
  3. rake db:migrate</br>
  4. rake db:setup</br>

Tänk bara på att gå in och hämta en ny apinyckel då dessa förnyas vid en db:setup




