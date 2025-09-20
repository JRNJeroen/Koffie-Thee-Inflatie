############ SETUP
setwd("C:/Users/Jeroe/OneDrive/Bureaublad/CBS")

library(tidyverse)
library(DBI)
library(cbsodataR)
source("cpi_kwartaal_mutatie.R")
source("load_to_db.R")

############ CONSTANTS / CONFIG

# CPI data id; prijsindex 2015=100
cpi_id <- "83131NED" 

# product id
koffie <- "CPI012110"
thee <- "CPI012120"

# report period - min: 1996-Q1, max: 2025-Q2
start_year <- 1996
start_quarter <- 1
end_year <- 1998
end_quarter <- 4

# output target
db_name <- "cpi_kwartaal_mutaties.sqlite"
db_table_name <- "quarterly_cpi"
overwrite <- TRUE

############ IMPORT DATA

# get data from API
cpi_data <- cbs_get_data(cpi_id)

############ KWARTAAL MUTATIE

start_date <- year_quarter_to_date(start_year, start_quarter, last_day = FALSE)
end_date <- year_quarter_to_date(end_year, end_quarter, last_day = TRUE)

koffie_cpi <- cpi_kwartaal_mutatie(cpi_data, koffie, start_date, end_date)
thee_cpi <- cpi_kwartaal_mutatie(cpi_data, thee, start_date, end_date)

output_table <- rbind(mutate(koffie_cpi, product = "koffie"),
                      mutate(thee_cpi, product = "thee"))

############ GRAFIEKEN

koffie_cpi_plot <- koffie_cpi %>%
  mutate(
    label = paste0(year, "-Q", quarter),
    label = factor(label, levels = label[order(q_start_date)])
  )
  
p_koffie_prijs <- ggplot(koffie_cpi_plot, aes(x = label, y = cpi, group = 1)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(color = "black", size = 2) +
    labs(
      title = "Koffie CPI Over Time",
      x = "Kwartaal",
      y = "CPI"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

thee_cpi_plot <- thee_cpi %>%
    mutate(
      label = paste0(year, "-Q", quarter),
      label = factor(label, levels = label[order(q_start_date)])
    )
  
p_thee_prijs <- ggplot(thee_cpi_plot, aes(x = label, y = cpi, group = 1)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(color = "black", size = 2) +
    labs(
      title = "Thee CPI Over Time",
      x = "Kwartaal",
      y = "CPI"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
############ WRITE TO DATABASE

table_to_db(output_table, db_name, db_table_name, overwrite)


