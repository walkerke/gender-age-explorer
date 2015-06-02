library(dplyr)
library(tidyr)
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

# Build the dot plot (test)

df <- get_sexratio("CH", seq(1990, 2050, 10))

max_x <- max(df$Ratio, na.rm = TRUE)


df %>% 
  dimple(Age ~ Ratio, type = "bubble", height = 600, width = 600, storyboard = "Year") %>%
  xAxis(type = "addMeasureAxis", title = "Number of males per 100 females", overrideMax = max_x) %>%
  yAxis(type = "addCategoryAxis", orderRule = "Order", showGridlines = TRUE) %>%
  default_colors(c("red", "red")) %>%
  tack(., options = list(
    chart = htmlwidgets::JS('function() {
                            var self = this;
                            self.svg.append("line")
                              .attr("x1", self.axes[0]._scale(100))
                              .attr("x2", self.axes[0]._scale(100))
                              .attr("y1", self._yPixels())
                              .attr("y2", self._yPixels() + self._heightPixels())
                              .style("stroke", "black")
                              .style("stroke-dasharray", "3");
                            return self;
                            }
                            ')
  ))