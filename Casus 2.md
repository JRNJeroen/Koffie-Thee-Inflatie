# Case 2

Het doel van de automatisering is om te zorgen dat het inladen van de data, het uitvoeren van de transformaties en het wegschrijven van de output niet meer handmatig hoeft te worden gedaan, maar uitgevoerd kan worden via een R-script. Daarnaast moet voorkomen worden dat de code bij elke uitvoering handmatig moet worden aangepast. Verder moet er gezorgd worden dat het project goed te onderhouden is door andere engineers, betrouwbaar werkt en datakwaliteit garandeert.

## Projectorganisatie

Ik zou mijn project op de volgende manier organiseren:

- Een main script voor het uitvoeren van de verwerkingsstraat
- Een R-script met een functie voor het inladen van het Excelbestand van afdeling A
- Een R-script met een functie voor het inladen van de data van afdeling B via de StatLine API
- Een R-script met een functie die verbinding maakt met de database van afdeling C en daaruit de data ophaalt via een SQL-query
- Een R-script met een functie die de raming van de landbouwrekeningen kan maken
- Een R-script dat de output schrijft naar de opslaglocatie
- Een R-script dat de configuraties ophaalt uit een configuratiebestand (indien nodig)

Deze organisatie zorgt ervoor dat de verschillende onderdelen van de verwerking als modules werken die los van elkaar herbruikbaar zijn.

## Belangrijke aspecten

### Documentatie, versiebeheer, reproduceerbaarheid en foutgevoeligheid

- De code moet in een online Git-repository staan en niet lokaal op iemands computer.
- De code moet uitgevoerd worden op een server en niet op de eigen computer.
- De repository dient voorzien te zijn van:
  - een beschrijving van wat de code doet,
  - hoe de verschillende bestanden georganiseerd zijn,
  - welke input nodig is voor gebruik,
  - welke afhankelijkheden de scripts hebben.
- De code in de scripts moet netjes opgemaakt zijn met duidelijke namen en opmerkingen die toelichten waarom bepaalde stappen worden uitgevoerd.
- Bij het inladen van de data uit de bronnen moet zo strikt mogelijk gecheckt worden op:
  - de correctheid van de datastructuur,
  - datatypes,
  - inhoud.
- Ook de output moet gecheckt worden op de correctheid van:
  - de datastructuur,
  - datatypes,
  - inhoud.
- Als de input of output niet klopt, moeten de scripts aangeven waar de fout vandaan komt.
- Eventuele configuratie dient als inputparameters te worden aangeleverd, niet als handmatige aanpassingen in de code.
- Bij elke uitvoering dient er een logbestand te worden aangemaakt dat de meegegeven instellingen en input- en outputlocaties bijhoudt.
- Er is gespecificeerd welke versie van R en welke R-packages worden gebruikt, zodat de omgevingen reproduceerbaar zijn. Hiervoor kan eventueel ook containerization worden toegepast om meteen het operating systeem mee te nemen.
- De opslaglocatie dient een database of cloudopslagplaats te zijn en niet een lokaal bestand.
