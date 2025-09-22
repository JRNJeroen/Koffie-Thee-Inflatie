############ SETUP
setwd("C:/Users/Jeroe/OneDrive/Bureaublad/CBS")

library(tidyverse)
library(DBI)
library(cbsodataR)
library(lubridate)
source("cpi_kwartaal_mutatie.R")
source("cpi_graphs.R")
source("load_to_db.R")

############ CONSTANTS / CONFIG

# CPI data id; prijsindex 2015=100
cpi_id <- "83131NED" 

# product id
koffie <- "CPI012110"
thee <- "CPI012120"
products <- c(koffie, thee)

# report period - min: 1996-Q1, max: 2025-Q2
start_year <- 1996
start_quarter <- 2
end_year <- 1998
end_quarter <- 4

# output target
db_name <- "cpi_kwartaal_mutaties.sqlite"
db_table_name <- "quarterly_cpi"
overwrite <- TRUE

############ IMPORT DATA

# get data from StatLine API
cpi_data <- cbs_get_data(cpi_id)

############ KWARTAAL MUTATIE

# get dates for start and end of period
start_date <- year_quarter_to_date(start_year, start_quarter, last_day = FALSE)
end_date <- year_quarter_to_date(end_year, end_quarter, last_day = TRUE)

# CPI and CPI mutation by quarter
cpi_kwartaal <- cpi_kwartaal_mutatie(cpi_data, products, start_date, end_date)

koffie_cpi <- cpi_kwartaal %>% filter(Bestedingscategorieen == koffie)
thee_cpi <- cpi_kwartaal %>% filter(Bestedingscategorieen == thee)

############ GRAFIEKEN

periode_string <- paste0(start_year, "-Q", start_quarter, " t/m ", end_year, "-Q", end_quarter)

koffie_title1 <- paste0("CPI Koffie: ", periode_string)
cpi_lineplot(koffie_cpi, koffie_title1)

thee_title1 <- paste0("CPI Thee: ", periode_string)
cpi_lineplot(thee_cpi, thee_title1)

koffie_title2 <- paste0("CPI Mutatie Koffie: ", periode_string)
mutatie_barplot(koffie_cpi, koffie_title2)

thee_title2 <- paste0("CPI Mutatie Thee: ", periode_string)
mutatie_barplot(thee_cpi, thee_title2)

############ WRITE TO DATABASE

table_to_db(cpi_kwartaal, db_name, db_table_name, overwrite)

