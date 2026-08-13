library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("WA Nursing Home Quality Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = 'county_filter',
        label = 'county',
        choices = c("All"),
        selected = 'All'
      ),
      
      sliderInput(
        inputId ='rating_filter',
        label = 'Minimum Overall Rating',
        min = 1,
        max = 5,
        value = 1,
        step = 1
      )
      
    ),
    
    mainPanel(
      leafletOutput("map")
      
    )
  )
)
