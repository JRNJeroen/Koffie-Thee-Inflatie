add_year_quarter_date <- function(table) {
  # Extract month and year
  month <- str_sub(table$Perioden, 7, 8)
  year <- str_sub(table$Perioden, 1, 4) %>% as.numeric()
  
  # Determine quarter
  quarter <- case_when(
    month %in% c("01", "02", "03") ~ 1,
    month %in% c("04", "05", "06") ~ 2,
    month %in% c("07", "08", "09") ~ 3,
    month %in% c("10", "11", "12") ~ 4
  )
  
  # Construct date (first day of month)
  date <- lubridate::ymd(paste(year, month, "01", sep = "-"))
  
  table <- table %>%
    mutate(
      year = year,
      quarter = quarter,
      date = date
    )
  
  return(table)
}

year_quarter_to_date <- function(year_input, quarter_input, last_day = FALSE) {
  first_month <- (quarter_input - 1) * 3 + 1 # first month of quarter
  
  # return either last or first day of quarter
  if (last_day) {
    return_date <- (make_date(year_input, first_month, 1) %m+% months(3)) - days(1)
  } else {
    return_date <- make_date(year_input, first_month, 1)
  }
  
  return(return_date)
}

cpi_kwartaal_mutatie <- function(table, product_list, start_d, end_d) {
  
  # compute table mean CPI per quarter for product
  quarterly_cpi <- table %>%
    filter(
      Bestedingscategorieen %in% product_list,
      str_sub(Perioden, 7, 8) != "00"            # periods ending on 00 are year entries, not month
    ) %>%
    add_year_quarter_date() %>%                  # adds columns: year, quarter and date (as first day of month)
    filter(
      date >= start_d,
      date <= end_d
    ) %>%
    group_by(year, quarter, Bestedingscategorieen) %>% 
    summarize(cpi = mean(CPI_1), .groups = "drop") %>%
    mutate(q_start_date = year_quarter_to_date(year, quarter, last_day = FALSE))
  
  # table where dates have CPI of previous quarter
  previous_cpi <- quarterly_cpi %>%
    mutate(
      q_start_date = q_start_date %m+% months(3),
      cpi_previous_quarter = cpi
    ) %>%
    select(q_start_date, cpi_previous_quarter, Bestedingscategorieen)
  
  # join the tables and compute the change in CPI
  result <- quarterly_cpi %>%
    left_join(previous_cpi, by = c("q_start_date", "Bestedingscategorieen")) %>%
    mutate(cpi_mutatie = (cpi - cpi_previous_quarter) / cpi * 100)
  
  return(result)
}


