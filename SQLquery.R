library(DBI)
library(RSQLite)

con <- dbConnect(SQLite(), "cpi_kwartaal_mutaties.sqlite")

result <- dbGetQuery(con, "
  SELECT 
  *
  FROM quarterly_cpi
")

print(result)

dbDisconnect(con)