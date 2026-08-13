library(shiny)
library(leaflet)
library(readr)
server <- function(input, output, session) {
  
  wa_nursing_homes <- read_csv("../data/clean/wa_nursing_homes.csv")  
  
  
  pal <- colorNumeric(palette = "RdYlGn", domain = wa_nursing_homes$overall_rating)
  
  output$map <-renderLeaflet({
    leaflet(wa_nursing_homes) %>%
      addTiles()%>%
      addCircleMarkers(
        lng = ~longitude, 
        lat = ~latitude, 
        popup = ~provider_name, 
        color = ~pal(overall_rating),
        radius = 6,
        fillOpacity = 0.8) %>%
      addLegend(
        position = "bottomright",
        pal = pal,
        values = ~overall_rating,
        opacity = 1
      )
    
  })
  
  
  
  
}