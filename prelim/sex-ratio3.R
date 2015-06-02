library(dplyr)
library(rvest)
library(rcdimple)

# Function to fetch the data from the US Census Bureau website

get_sexratio <- function(country, year) {
  
  c1 <- "http://www.census.gov/population/international/data/idb/region.php?N=%20Results%20&T=10&A=separate&RT=0&Y="
  
  c2 <- "&R=-1&C="
  
  yrs <- gsub(" ", "", toString(year))
  
  url <- paste0(c1, yrs, c2, country)
  
  df <- url %>%
    html() %>%
    html_nodes("table") %>%
    html_table() %>%
    data.frame()
  
  names(df) <- c("Year", "Age", "total", "Male", "Female", "percent", "pctMale", "pctFemale", "Ratio") 
  
  cols <- c(1, 3:9)
  
  df[,cols] <- apply(df[,cols], 2, function(x) as.numeric(as.character(gsub(",", "", x))))
  
  df1 <- df %>%
    mutate(Order = 1:nrow(df)) %>%
    filter(Age != "Total") %>%
    select(Year, Age, Ratio, Order) 
  
  df1
  
}

# Build the dot plot - China from 1990 to 2050, in 5 year intervals

df <- get_sexratio("AE", seq(1990, 2050, 5))

max_x <- max(df$Ratio, na.rm = TRUE)


df %>% 
  dimple(Age ~ Ratio, type = "bubble", height = 600, width = 600, storyboard = "Year") %>%
  xAxis(type = "addMeasureAxis", title = "Number of males per 100 females", overrideMax = max_x, 
        showGridlines = FALSE, fontSize = 18) %>%
  yAxis(type = "addCategoryAxis", orderRule = "Order", showGridlines = TRUE, fontSize = 18) %>%
  default_colors(c("green", "red")) %>%
  tack(., options = list(
    tasks = htmlwidgets::JS('
                            function(){
                            var chart = this.widgetDimple[0];
                            chart.svg.append("line")
                            .attr("x1",chart.axes[0]._scale(100))
                            .attr("x2",chart.axes[0]._scale(100))
                            .attr("y1",chart._yPixels())
                            .attr("y2", chart._yPixels() + chart._heightPixels())
                            .style("stroke", "blue")
                            .style("stroke-dasharray", "8") 
                            }')))

