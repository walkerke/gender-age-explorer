# gender-age-explorer
This is a very alpha Shiny application to explore the gender and age structure of the world's countries with population pyramids and dot plots.  Data for the application come from [the US Census Bureau's International Database](http://www.census.gov/population/international/data/idb/informationGateway.php).  Users can change the year between 1990 and 2050 (projected) and the color of the plot, and download the plot as a standalone HTML file.  

The application is built using the Shiny framework implemented in the R programming language.  The plots are rendered in D3.js using the Dimple.js library.  To run the application locally, issue the following command in RStudio: `shiny::runGitHub('walkerke/gender-age-explorer')`.  

Future iterations of the app will include capacity for temporal animations and various bug fixes.  Please explore and let me know what you think!
