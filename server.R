library(shiny)
library(rcdimple)

source('setup.R')


shinyServer(function(input, output, session) {
  
  # Fetch the data
  pyramid_data <- reactive({
    get_data(input$country, input$year)
  })
  
  dotplot_data <- reactive({
    get_sexratio(input$country1, input$year1)
  })

  # Output for the population pyramid
  
  output$pyramid <- renderDimple({
    
   pyramid_data() %>%
    build_pyramid() %>%
    default_colors(input$color1, input$color2)
    
   
  })
  
  output$downloadPyramid <- downloadHandler(
    filename = "pyramid.html", contentType = "text/plain", 
    content = function(file) {
      out <- pyramid_data() %>% build_pyramid() %>% default_colors(input$color1, input$color2)
      htmlwidgets::saveWidget(out, file)
    }
  )
  
  # Output for the dot plot
  
  output$dotplot <- renderDimple({
    
    dotplot_data() %>%
      build_dotplot() %>%
      default_colors(input$color3, "red")
    
  })
  
  output$downloadDotplot <- downloadHandler(
    filename = "dotplot.html", contentType = "text/plain", 
    content = function(file) {
      out <- dotplot_data() %>% build_dotplot() %>% default_colors(input$color3, "red")
      htmlwidgets::saveWidget(out, file)
    }
    
    
    
  )
  
  
})