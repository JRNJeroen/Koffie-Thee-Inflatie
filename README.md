# Data Engineer IT casus

Deze repository bevat R-scripts en andere bestanden die horen bij **Casus 1** en een Markdown-bestand waarin **Casus 2** is uitgewerkt.

Voor **Casus 1** heb ik ervoor gekozen om de producten **koffie** en **thee** te onderzoeken.

## Bestandsstructuur

- **main.R**  
Het uitvoerende script dat dient als **startpunt en configuratiebestand**. Het script voert de volgende stappen uit:  
  1. **Pakketten en functies inladen**  
  2. **Instellingen definiëren** – dataset- en productcodes, rapporteringsperiode en database-naam instellen  
  3. **Data ophalen** – CPI-data importeren via de StatLine API  
  4. **Berekeningen uitvoeren** – per kwartaal:  
     - het CPI voor de geselecteerde producten berekenen  
     - de procentuele mutatie ten opzichte van het vorige kwartaal bepalen  
  5. **Visualisaties maken** – grafieken van de kwartaalresultaten genereren (opgeslagen in deze repository)  
  6. **Resultaten opslaan** – de berekende waarden wegschrijven naar een SQLite-database  

- **cpi_kwartaal_mutatie.R**  
  Bevat drie functies voor het transformeren van de inputdata:  
  1. Een functie die op basis van de Periode-code het jaar, kwartaal en de eerste dag van de maand bepaalt en toevoegt aan de dataset.  
  2. Een functie die, gegeven een jaar en kwartaal, de eerste of laatste dag van dat kwartaal bepaalt.  
  3. Een functie die voor elk kwartaal in een opgegeven periode het CPI van een gekozen product berekent, inclusief de procentuele verandering.

- **load_to_db.R**  
  Bevat een functie die een tabel wegschrijft naar een SQLite-databasebestand.

- **cpi_graphs.R**  
  Bevat templates voor verschillende grafieken en helper functies voor het voorbereiden van de data.

## Configuraties in main.R

In `main.R` worden een aantal configuratie-instellingen gedefinieerd die het proces sturen:  

- **Dataset en productcodes**  
  - `cpi_id`: de datasetcode van de CPI-tabel uit de CBS-catalogus.  
  - `koffie` en `thee`: productcodes voor koffie en thee, afkomstig uit de meta data van de dataset.
  - `product_list`: vector met productcodes waarvoor de CPI kwartaal mutatie moet worden gedaan.

- **Rapporteringsperiode**  
  - `start_year`, `start_quarter`: beginpunt van de analyse.  
  - `end_year`, `end_quarter`: eindpunt van de analyse.  

- **Database-output**  
  - `db_name`: de naam van de SQLite-database.  
  - `db_table_name`: de naam van de tabel waarin de resultaten worden opgeslagen.  
  - `overwrite`: bepaalt of bestaande data in de database wordt overschreven.  

## Overige bestanden

- **cpi_kwartaal_mutaties.sqlite** – de daadwerkelijke data-output.  
- **SQLquery.R** – een kort script om data uit *cpi_kwartaal_mutaties.sqlite* in te lezen.  
- **KoffieCPI.png** – de grafiek met de kwartaal-CPI van koffie.  
- **TheeCPI.png** – de grafiek met de kwartaal-CPI van thee.
- **KoffieCPImutatie.png** – de grafiek met de kwartaal-CPI mutatie van koffie.  
- **TheeCPImutatie.png** – de grafiek met de kwartaal-CPI mutatievan thee.  
- **Casus 2.md** – de uitwerking van Casus 2.  

## Toelichting tools
- `cbsodataR` voor het ophalen van de data
- `tidyverse` paketten voor het verwerken van data
- `ggplot` en `scales` voor het maken van grafieken
- `DBI` en `RSQLite` voor het database interacties

## Afhankelijkheden  

Hieronder staan de specifieke pakketversies die gebruikt zijn, evenals de R-versie.

## Installed packages

| Package    | Version |
|------------|---------|
| scales     | 1.3.0   |
| DBI        | 1.2.3   |
| lubridate  | 1.9.3   |
| forcats    | 1.0.0   |
| stringr    | 1.5.1   |
| dplyr      | 1.1.4   |
| purrr      | 1.0.2   |
| readr      | 2.1.5   |
| RSQLite    | 2.4.3   |
| tidyr      | 1.3.1   |
| tibble     | 3.2.1   |
| ggplot2    | 3.5.1   |
| tidyverse  | 2.0.0   |
| cbsodataR  | 1.2.1   |


## System info

| Field          | Value                                  |
|----------------|----------------------------------------|
| platform       | x86_64-w64-mingw32                     |
| arch           | x86_64                                 |
| os             | mingw32                                |
| crt            | ucrt                                    |
| system         | x86_64, mingw32                        |
| status         |                                        |
| major          | 4                                      |
| minor          | 4.2                                    |
| year           | 2024                                   |
| month          | 10                                     |
| day            | 31                                     |
| svn rev        | 87279                                  |
| language       | R                                      |
| version.string | R version 4.4.2 (2024-10-31 ucrt)     |
| nickname       | Pile of Leaves                          |
