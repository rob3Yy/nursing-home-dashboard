library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("WA Nursing Home Quality Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      
    ),
    
    mainPanel(
      leafletOutput("map")
      
    )
  )
)
