# Get a data frame of FIPS 10-4 codes

library(rvest)
library(dplyr)

url <- "http://www.mapanet.eu/EN/Resources/FIPS.asp"

df <- url %>%
  html() %>%
  html_nodes("#table83") %>%
  html_table(fill = TRUE) %>%
  data.frame()

df$Country <- gsub("Argentine", "Argentina", df$Country)

write.csv(df, 'codes.csv', fileEncoding = "UTF-8")

# country_list <- setNames(as.list(df$FIPS), df$Country)

