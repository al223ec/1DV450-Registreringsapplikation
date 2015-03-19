<h2>SPA</h2>
<h4>Installation</h4>
<p>
	Kör bundle install "rake db:migrate" och "rake db:seed" följt av "rails s".<br>
	Api:et har routingen api.lvh.me:3000<br>
	Vill man köra testerna måste man köra rake db:migrate RAILS_ENV=test
</p>
<p>
	Tidigare har det varit problem med "gem 'bcrypt', '3.1.7'" och 	gem 'sqlite3', '1.3.9' men dessa har uppdateras i gem filen så det bör inte bli några problem.
</p>
<p>
	SPA nås via lvh.me:3000/spa. För att komma igång måste korrekt token sättas i spa.js, fås när man seedar databasen. Välj den token som hamnar sist i tabellen, för det är den applikationen som har en test-user knuten till sig. <br>
	spa.js hittas i app/assets/javascripts där också hela SPA koden är placerad.
</p>
<p>
	För att logga in ange end_user@mail.com pw: foobar. Det går att logga in med vilken som helst av de skapade användarna med de får en random email address, lösenordet är dock alltid password.
</p>
<h4>Förändringar i Api:et</h4>
<p>
Har inte behövt göra några stora förändringar alls, det enda jag förändrat är att förändra hur objekten ser ut istället för event:{} returneras {}. Detta för att det är ganska fult att skriva event.event när man hämtar ut events och ska loopa igenom dessa.<br>
Dessutom för att kunna hantera pagineringen adderade jag en total_entries property.
</p>
<p>
Det som borde tillkomma är att man optimerar och förbättrar sökfunktionene i API:et i dagsläget ställs bara "like" frågor till databasen vilket inte ger så väldigt bra svar alla gånger. <br>
Sedan finns det en bugg när man hämtar ut event filtrerade på tags, dessa får endast den aktuella taggen knuten till sig. Detta beror på sättet jag hämtar ut events från databasen, hämtar ut event med den aktuella taggen och tar inte med om det finns några andra taggar. <br>
Jag har också implementerat en annan felhantering som jag fick input för under den senaste peer review.
</p>
<h4>Reflektion</h4>
<p>
Jag har i min implementation av en SPA försökt visa på fördelarna med REST och ett HATEOAS tänk. Jag har valt att inte använda mig av en kart tjänst, har utvecklat två applikationer tidigare med hjälp av google maps, jag har valt att mer fokusera på andra aspekter av applikationen, där jag personligen känner att jag har större möjlighet att fördjupa min förståelse för AngularJs. <br>
Jag hade tänkt att implementera en karta i mån av tid, tid som inte fanns där innan det var färdigt. Man kan därför i applikationen inte skapa nya positioner.
</p>
<p>
Det finns också förberett för browser tester med hjälp av phantom.js och teaspoon samt möjlighet att skriva rspec tester. Har inte hunnit skriva några tester för frontend trots det, var mycket annat under den här perioden som har tagit väldigt mycket tid.<br>
Jag önskar att jag haft mer tid att kunna genomföra automatiserade tester för front-end, jag känner att jag utvecklas mycket som programmerare, med större möjlighet att reflektera och skriva bättre kod när jag har möjlighet att också skriva tester för min kod.
</p>
<p>
Jag har också haft problem med testernas databas, får inte till att browser testerna använder testdatabasen utan de använder också development databasen vilket inte är önskvärt.
</p>

<h2>Api:et</h2>
<p>
	Kör bundle install "rake db:migrate" och "rake db:seed" följt av "rails s".<br>
	Api:et har routingen api.lvh.me:3000<br>
	Vill man köra testerna måste man köra rake db:migrate RAILS_ENV=test
</p>
<p>
	Headern måste innehålla en Authorization med värdet Token token="api-key". För att kunna skapa objekt krävs att man skickar med en JWT denna får man ut genom att logga in med en användare.<br>
	JWT skickas med header i JWT.<br>
	Tror att postman filen täcker det mesta man kan göra i api:et, ligger i rooten av repot, man måste uppdatera token värdet med det värdet man får ut från seeden.
</p>
<ul>
	<li>Seedad end user</li>
	<li>end_user[email] = end_user@mail.com</li>
	<li>end_user[password] = foobar</li>
</ul>

<h2>Tidigare problem</h2>
<p>
Jag kom så långt att jag kunde köra "bundle install", men när jag försökte köra "rails s" så fick jag ett error om bcrypt.
</p>
<p>
Löste problemet genom att byta ut föregående raden:
"gem 'bcrypt', '3.1.7'"
<br>
mot raden:<br>

gem 'bcrypt', '~> 3.1.9' <br>
(Det var alltså fel version på bcrypt... som ej fungerade med windows..)
</p>
<p>
	Samma sak gällde sqlite3, lösningen blev följande:
	gem 'sqlite3', '1.3.9'
	byttes ut till:
	gem 'sqlite3', '1.3.10'
</p>
<p>
	Körde "rake db:migrate" och "rake db:seed" följt av "rails s".
	Nu fungerade sidan och allt som det skulle.
</p>
<h2>Webbapplikation för API-nyckel</h2>
<p>
	Byggd i Windows 8.1, för att komma igång och testköra applikationen borde det bara vara att köra bundle install, däerefter bundle exec rake db:migrate och seed om man vill. Utan seed saknas testdata och ingen admin användare finns.
</p>
<ul>
	<li>bundle install</li>
	<li>rails --version v 4.2.0</li>
	<li>ruby 2.0.0p247 [x64-mingw32]</li>
	<li>
		Db i development är en sqlite3, för migrations
		<ul>
			<li>
				bundle exec rake db:migrate
			</li>
			<li>
				bundle exec rake db:seed
			</li>
			<li>
				Användare för admin rättigheter: <br>
				mail: example@mail.com <br>
				pw: foobar
			</li>
		</ul>
	</li>
</ul>

<h2>Om registreringsapplikationen</h2>
<p>Till tjänsten ska en registreringsapplikation utvecklas där utvecklare (som vill använda ditt API) ska kunna få tillgång till en giltig API-nyckel som kan användas i API-anropen för samtliga resurser. </p>

<p>Detta blir en webbapplikation som är fristående från själva API:et. </p>

<p>Registreringsapplikationen bör bestå av ett enkelt formulär där utvecklaren registrerar sin applikation och det genereras en hashad API-nyckel som visas för användaren. </p>

<p>Applikationsutvecklaren registrerar sig med en e-postadress och gärna lämplig information kring applikationen. En registrerad e-post kan endast ha en giltig API-nyckel. Den registerade applikationsutvecklaren ska kunna logga in i systemet och se/ta bort sin genererade API-nyckel.
Applikationen ska ha ett administratörskonto (OK att hårdkoda in) med rättigheter att kunna ta bort befintliga API-nycklar (revoke application). Vi behöver alltså även något sätt för en administratör att logga in och enkelt hantera API-nycklar.</p>

<h2>Krav</h2>
<ul>
<li>Registreringsformulär för en utvecklare där en giltig API-nyckel skapas vid registrering och sparas undan för att använda när man kontrollerar anrop till API:et</li>
<li>Inloggning för en registrerad applikationsutvecklare att kunna se / ta bort sin nykel.</li>
<li>Inloggningsformulär för en administratör</li>
<li>En sida där den inloggade administratören kan ta bort(revoke) befintliga API-nycklar</li>
<li>Applikationen ska versionhanteras via ett öppet repo på Github</li>
<li>Applikationen ska fungera väl och det ska i repositoriet finnas en beskrivning hur man installerar och kör igång applikationen (ni kommer göra peer-reviews på varandras applikationer)</li>
<li>Eventuella frågor kring registreringsapplikationen kan diskuteras under de schemalagda handledningspassen.</li>
</ul>
