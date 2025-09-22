factorize_kwartaal <- function(table) {
  return_table <- table %>% 
    mutate(label = paste0(year, "-Q", quarter), 
           qlabel = factor(label, levels = label[order(q_start_date)]) )
  return(return_table)
}


cpi_lineplot <- function(table, title_string) {
  
  table_plot <- factorize_kwartaal(table)
  
  # line plot with dots
  cpi_plot <- ggplot(table_plot, aes(x = qlabel, y = cpi, group = 1)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(color = "black", size = 2) +
    labs(
      title = title_string,
      x = "Kwartaal",
      y = "CPI"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  return(cpi_plot)
}

mutatie_barplot <- function(table, title_string) {
  
  table_plot <- table %>%
    mutate(cpi_mutatie = replace_na(cpi_mutatie, 0)) %>%
    factorize_kwartaal()
  
  mutatie_plot <- ggplot(table_plot, aes(x = qlabel, y = cpi_mutatie, fill = cpi_mutatie > 0)) +
    geom_bar(stat = "identity", alpha = 1) +
    scale_fill_manual(values = c("TRUE" = "#6baed6",
                                 "FALSE" = "#f1696b"),
                      guide = "none") +
    labs(x = "Kwartaal", 
         y = "CPI Mutatie", 
         title = title_string) +
    scale_y_continuous(labels = scales::percent_format(scale = 1)) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  return(mutatie_plot)
}