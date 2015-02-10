<h2>Webbapplikation för API-nyckel</h2>
<p>
	Byggd i Windows 8.1. 
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