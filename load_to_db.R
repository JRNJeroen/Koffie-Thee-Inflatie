table_to_db <- function(table, db, table_name, overwrite) {
  con <- dbConnect(RSQLite::SQLite(), db)
  dbWriteTable(con, table_name, table, overwrite = overwrite)
  dbDisconnect(con)
}