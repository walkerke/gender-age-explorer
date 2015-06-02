library(shiny)
library(shinythemes)
library(rcdimple)

source('setup.R')

shinyUI(navbarPage("International gender & age explorer", theme = shinytheme("spacelab"),  
  tabPanel('Population pyramid',
  sidebarLayout(
  sidebarPanel(  
    selectInput('country', 'Select a country', country_list),
    numericInput('year', 'Year', 2015,
                 min = 1990, max = 2050), 
    textInput("color1", "Color (male)", value = "blue"), 
    textInput("color2", "Color (female)", value = "red"),
    downloadButton('downloadPyramid', "Download plot (HTML)"), 
    p("Data come from the ", 
    a("US Census Bureau's International Database. ", 
      href = "http://www.census.gov/population/international/data/idb/informationGateway.php")), 
    br(), 
    p("App author: ", 
      a("Kyle Walker, Texas Christian University.  ", 
        href = "http://personal.tcu.edu/kylewalker"), 
      a("Code on GitHub.", href = "https://github.com/walkerke/dimple-pyramid"), 
      " This app was built in R and Dimple.js using the rcdimple package."), 
    p("Many thanks to ", a("Kenton Russell, ", href = "https://twitter.com/timelyportfolio"), 
      a("John Kiernander, ", href = "https://twitter.com/jkiernander"), 
      a("Ramnath Vaidyanathan, ", href = "https://twitter.com/ramnath_vaidya"), "and the whole RStudio team!")
  ),
  mainPanel(
    dimpleOutput('pyramid', height = "800px")
  )
  )
  ), 

  tabPanel('Sex ratio dot plot', 
     sidebarLayout(
       sidebarPanel(
         selectInput('country1', 'Select a country', country_list), 
         numericInput('year1', 'Year', 2015, min = 1990, max = 2050), 
         textInput("color3", "Color", value = "blue"), 
         downloadButton('downloadDotplot', "Download plot (HTML)"), 
         p("Data come from the ", 
           a("US Census Bureau's International Database. ", 
             href = "http://www.census.gov/population/international/data/idb/informationGateway.php")), 
         br(), 
         p("App author: ", 
           a("Kyle Walker, Texas Christian University.  ", 
             href = "http://personal.tcu.edu/kylewalker"), 
           a("Code on GitHub.", href = "https://github.com/walkerke/dimple-pyramid"), 
           " This app was built in R and Dimple.js using the rcdimple package."), 
         p("Many thanks to ", a("Kenton Russell, ", href = "https://twitter.com/timelyportfolio"), 
           a("John Kiernander, ", href = "https://twitter.com/jkiernander"), 
           a("Ramnath Vaidyanathan, ", href = "https://twitter.com/ramnath_vaidya"), "and the whole RStudio team!")
       ),
      mainPanel(
        dimpleOutput('dotplot', height = "800px")
      )
       )
     )      



)

)