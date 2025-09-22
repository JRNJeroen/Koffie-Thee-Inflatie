# Data Engineer IT casus

Deze repository bevat R-scripts en andere bestanden die horen bij **Casus 1** en een Markdown-bestand waarin **Casus 2** is uitgewerkt.

Voor **Casus 1** heb ik ervoor gekozen om de producten **koffie** en **thee** te onderzoeken.

## Bestandsstructuur

- **main.R**  
  Dit script voert de gehele verwerkingsstraat uit en dient ook als configuratiebestand. Het importeert de CPI-dataset via de functie `cbs_get_data()` uit het *cbsodataR*-pakket, berekent het CPI voor twee producten (koffie en thee) per kwartaal in een opgegeven periode, maakt grafieken van deze kwartaalcijfers (de afbeeldingen zijn opgenomen in de repository) en schrijft de berekende waarden weg naar een SQLite-database.

- **cpi_kwartaal_mutatie.R**  
  Bevat drie functies voor het transformeren van de inputdata:  
  1. Een functie die op basis van de Periode-code het jaar, kwartaal en de eerste dag van de maand bepaalt en toevoegt aan de dataset.  
  2. Een functie die, gegeven een jaar en kwartaal, de eerste of laatste dag van dat kwartaal bepaalt.  
  3. Een functie die voor elk kwartaal in een opgegeven periode het CPI van een gekozen product berekent, inclusief de procentuele verandering.

- **load_to_db.R**  
  Bevat een functie die een tabel wegschrijft naar een SQLite-databasebestand.

## Configuraties in main.R

In `main.R` worden een aantal configuratie-instellingen gedefinieerd die het proces sturen:  

- **Dataset en productcodes**  
  - `cpi_id`: de datasetcode van de CPI-tabel uit de CBS-catalogus.  
  - `koffie` en `thee`: productcodes voor koffie en thee, afkomstig uit de meta data van de dataset.  

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
- **Casus 2.md** – de uitwerking van Casus 2.  

## Afhankelijkheden

De R-scripts maken gebruik van een aantal pakketten:  
- **cbsodataR** om CPI-data uit StatLine te downloaden.  
- **tidyverse**-pakketten voor dataverwerking.  
- **DBI** en **RSQLite** om een SQLite-database aan te maken en ermee te werken.  

Hieronder staan de specifieke pakketversies die gebruikt zijn, evenals de R-versie.

## Installed packages

| Package   | Name       | Version |
|-----------|------------|---------|
| cbsodataR | "cbsodataR" | "1.2.1" |
| DBI       | "DBI"       | "1.2.3" |
| dplyr     | "dplyr"     | "1.1.4" |
| forcats   | "forcats"   | "1.0.0" |
| ggplot2   | "ggplot2"   | "3.5.1" |
| lubridate | "lubridate" | "1.9.3" |
| purrr     | "purrr"     | "1.0.2" |
| readr     | "readr"     | "2.1.5" |
| RSQLite   | "RSQLite"   | "2.4.3" |
| stringr   | "stringr"   | "1.5.1" |
| tibble    | "tibble"    | "3.2.1" |
| tidyr     | "tidyr"     | "1.3.1" |

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
