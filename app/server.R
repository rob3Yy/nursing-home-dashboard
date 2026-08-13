library(shiny)
library(leaflet)
library(readr)
server <- function(input, output, session) {
  
  wa_nursing_homes <- read_csv("../data/clean/wa_nursing_homes.csv")  
  
  output$map <-renderLeaflet({
    leaflet(wa_nursing_homes) %>%
      addTiles()%>%
      addMarkers(lng = ~longitude, lat = ~latitude, popup = ~provider_name)
    
  })
  
  
  
  
}